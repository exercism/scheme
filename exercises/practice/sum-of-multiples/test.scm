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

(define sum-of-multiples)

(define test-cases
  (list
    (lambda ()
      (test-success "no multiples within limit"
                    equal? sum-of-multiples '((3 5) 1) 0))
    (lambda ()
      (test-success "one factor has multiples within limit"
                    equal? sum-of-multiples '((3 5) 4) 3))
    (lambda ()
      (test-success "more than one multiple within limit"
                    equal? sum-of-multiples '((3) 7) 9))
    (lambda ()
      (test-success "more than one factor with multiples within limit"
                    equal? sum-of-multiples '((3 5) 10) 23))
    (lambda ()
      (test-success "each multiple is only counted once"
                    equal? sum-of-multiples '((3 5) 100) 2318))
    (lambda ()
      (test-success "a much larger limit"
                    equal? sum-of-multiples '((3 5) 1000) 233168))
    (lambda ()
      (test-success "three factors"
                    equal? sum-of-multiples '((7 13 17) 20) 51))
    (lambda ()
      (test-success "factors not relatively prime"
                    equal? sum-of-multiples '((4 6) 15) 30))
    (lambda ()
      (test-success "some pairs of factors relatively prime and some not"
                    equal? sum-of-multiples '((5 6 8) 150) 4419))
    (lambda ()
      (test-success "one factor is a multiple of another"
                    equal? sum-of-multiples '((5 25) 51) 275))
    (lambda ()
      (test-success "much larger factors"
                    equal? sum-of-multiples '((43 47) 10000) 2203160))
    (lambda ()
      (test-success "all numbers are multiples of 1"
                    equal? sum-of-multiples '((1) 100) 4950))
    (lambda ()
      (test-success "no factors means an empty sum"
                    equal? sum-of-multiples '(() 10000) 0))
    (lambda ()
      (test-success "the only multiple of 0 is 0"
                    equal? sum-of-multiples '((0) 1) 0))
    (lambda ()
      (test-success
        "the factor 0 does not affect the sum of multiples of other factors"
        equal? sum-of-multiples '((3 0) 4) 3))
    (lambda ()
      (test-success
        "solutions using include-exclude must extend to cardinality greater than 3"
        equal? sum-of-multiples '((2 3 5 7 11) 10000) 39614537))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "sum-of-multiples.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "sum-of-multiples.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

