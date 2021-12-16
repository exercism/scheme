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

(define (under-10? n)
  (< n 10))

(define (starts-with-z? s)
  (char=? (string-ref s 0) #\z))

(define keep)
(define discard)

(define test-cases
  (list
    (lambda ()
      (test-success "empty keep" equal? keep `(,under-10? ()) '()))
    (lambda ()
      (test-success "keep everything" equal? keep
                    `(,under-10? (0 2 4 6 8)) '(0 2 4 6 8)))
    (lambda ()
      (test-success "keep first last" equal? keep `(,odd? (1 2 3)) '(1 3)))
    (lambda ()
      (test-success "keep nothing" equal? keep `(,even? (1 3 5 7 9)) '()))
    (lambda ()
      (test-success "keep neither first nor last" equal? keep
                    `(,even? (1 2 3)) '(2)))
    (lambda ()
      (test-success
        "keep strings" equal? keep
        `(,starts-with-z? ("apple" "zebra" "banana" "zombies" "cherimoya" "zealot"))
        '("zebra" "zombies" "zealot")))
    (lambda ()
      (test-success "empty discard" equal? discard `(,under-10? ()) '()))
    (lambda ()
      (test-success "discard everything" equal? discard
                    `(,under-10? (1 2 3)) '()))
    (lambda ()
      (test-success "discard first and last" equal? discard
                    `(,odd? (1 2 3)) '(2)))
    (lambda ()
      (test-success "discard nothing" equal? discard
                    `(,even? (1 3 5 7 9)) '(1 3 5 7 9)))
    (lambda ()
      (test-success "discard neither first nor last" equal? discard
                    `(,even? (1 2 3)) '(1 3)))
    (lambda ()
      (test-success
        "discard strings" equal? discard
        `(,starts-with-z? ("apple" "zebra" "banana" "zombies" "cherimoya" "zealot"))
        '("apple" "banana" "cherimoya")))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "strain.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "strain.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

