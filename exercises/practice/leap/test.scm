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

(define leap-year?)

(define test-cases
  (list
    (lambda ()
      (test-success "year not divisible by 4 in common year" eqv?
        leap-year? '(2015) #f))
    (lambda ()
      (test-success
        "year divisible by 2, not divisible by 4 in common year"
        eqv? leap-year? '(1970) #f))
    (lambda ()
      (test-success
        "year divisible by 4, not divisible by 100 in leap year"
        eqv? leap-year? '(1996) #t))
    (lambda ()
      (test-success
        "year divisible by 4 and 5 is still a leap year" eqv?
        leap-year? '(1960) #t))
    (lambda ()
      (test-success
        "year divisible by 100, not divisible by 400 in common year"
        eqv? leap-year? '(2100) #f))
    (lambda ()
      (test-success
        "year divisible by 100 but not by 3 is still not a leap year"
        eqv? leap-year? '(1900) #f))
    (lambda ()
      (test-success "year divisible by 400 in leap year" eqv?
        leap-year? '(2000) #t))
    (lambda ()
      (test-success
        "year divisible by 400 but not by 125 is still a leap year"
        eqv? leap-year? '(2400) #t))
    (lambda ()
      (test-success
        "year divisible by 200, not divisible by 400 in common year"
        eqv? leap-year? '(1800) #f))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args)) (load "leap.scm") (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "leap.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

