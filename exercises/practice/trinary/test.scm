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

(define trinary)

(define test-cases
  (list
    (lambda ()
      (test-success
        "returns the decimal representation of the input trinary value" equal?
        to-decimal '("1") 1))
    (lambda ()
      (test-success "trinary 2 is decimal 2" equal? to-decimal '("2") 2))
    (lambda ()
      (test-success "trinary 10 is decimal 3" equal? to-decimal '("10") 3))
    (lambda ()
      (test-success "trinary 11 is decimal 4" equal? to-decimal '("11") 4))
    (lambda ()
      (test-success "trinary 100 is decimal 9" equal? to-decimal '("100") 9))
    (lambda ()
      (test-success "trinary 112 is decimal 14" equal? to-decimal '("112") 14))
    (lambda ()
      (test-success "trinary 222 is decimal 26" equal? to-decimal '("222") 26))
    (lambda ()
      (test-success
        "trinary 1122000120 is decimal 32091" equal?
        to-decimal '("1122000120") 32091))
    (lambda ()
      (test-success
        "invalid trinary digits returns 0" equal? to-decimal '("1234") 0))
    (lambda ()
      (test-success
        "invalid word as input returns 0" equal? to-decimal '("carrot") 0))
    (lambda ()
      (test-success
        "invalid numbers with letters as input returns 0" equal?
        to-decimal '("0a1b2c") 0))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "trinary.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "trinary.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

