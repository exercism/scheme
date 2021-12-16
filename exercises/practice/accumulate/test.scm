(import (except (rnrs) current-output-port))

(define test-fields '(input output))

(define (test-run-solution solution input)
  (if (procedure? solution) (apply solution input) solution))

(define (test-success description success-predicate
         procedure input output)
  (call/cc
    (lambda (k)
      (let ([out (open-output-string)])
        (with-exception-handler
          (lambda (e)
            (let ([result `(fail
                             (description . ,description)
                             (input . ,input)
                             (output . ,output)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              (k result)))
          (lambda ()
            (let ([result (parameterize ([current-output-port out])
                            (test-run-solution procedure input))])
              (unless (success-predicate result output)
                (error 'exercism-test
                  "test fails"
                  description
                  input
                  result
                  output)))
            (let ([result `(pass
                             (description . ,description)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              result)))))))

(define (test-error description procedure input)
  (call/cc
    (lambda (k)
      (let ([out (open-output-string)])
        (with-exception-handler
          (lambda (e)
            (let ([result `(pass
                             (description . ,description)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              (k result)))
          (lambda ()
            (parameterize ([current-output-port out])
              (test-run-solution procedure input))
            (let ([result `(fail
                             (description . ,description)
                             (input . ,input)
                             (output . error)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              result)))))))

(define (run-test-suite tests . query)
  (for-each
    (lambda (field)
      (unless (and (symbol? field) (memq field test-fields))
        (error 'run-test-suite
          (format #t "~a not in ~a" field test-fields))))
    query)
  (let-values ([(passes failures)
                (partition
                  (lambda (result) (eq? 'pass (car result)))
                  (map (lambda (test) (test)) tests))])
    (cond
      [(null? failures) (format #t "~%Well done!~%~%")]
      [else
       (format
         #t
         "~%Passed ~a/~a tests.~%~%The following test cases failed:~%~%"
         (length passes)
         (length tests))
       (for-each
         (lambda (failure)
           (format
             #t
             "* ~a~%"
             (cond
               [(assoc 'description (cdr failure)) => cdr]
               [else (cdr failure)]))
           (for-each
             (lambda (field)
               (let ([info (assoc field (cdr failure))])
                 (display "  - ")
                 (write (car info))
                 (display ": ")
                 (write (cdr info))
                 (newline)))
             query))
         failures)
       (error 'test "incorrect solution")])))

(define (run-docker test-cases)
  (write (map (lambda (test) (test)) test-cases)))

(define (square x) (* x x))

(define accumulate)

(define test-cases
  (list
    (lambda ()
      (test-success "empty list" equal? accumulate `(,identity ()) '()))
    (lambda ()
      (test-success "identity" equal? accumulate `(,identity (1 2 3)) '(1 2 3)))
    (lambda ()
      (test-success "1+" equal? accumulate `(,1+ (1 2 3)) '(2 3 4)))
    (lambda ()
      (test-success "squares" equal? accumulate `(,square (1 2 3)) '(1 4 9)))
    (lambda ()
      (test-success "upcases" equal? accumulate
                    `(,string-upcase ("hello" "world")) '("HELLO" "WORLD")))
    (lambda ()
      (test-success
        "reverse strings" equal? accumulate
        `(,string-reverse ("the" "quick" "brown" "fox" "jumps" "over" "the" "lazy" "dog"))
        '("eht" "kciuq" "nworb" "xof" "spmuj" "revo" "eht" "yzal" "god")))
    (lambda ()
      (test-success "length" equal? accumulate
                    `(,length ((a b c) (((d))) (e (f (g (h)))))) '(3 1 2)))
    (lambda ()
      (test-success
        "accumulate w/in accumulate" equal? accumulate
        `(,(lambda (x)
             (string-join
               (accumulate (lambda (y)
                             (string-append x y))
                           '("1" "2" "3"))
               " "))
           ("a" "b" "c"))
        '("a1 a2 a3" "b1 b2 b3" "c1 c2 c3")))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "accumulate.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "accumulate.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

