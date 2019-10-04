#!r6rs
(import (rnrs))

(define test-fields '(input output who))

(define (test-run-solution solution input)
  (if (procedure? solution) (apply solution input) solution))

(define (test-success description success-predicate
         procedure input output)
  (call/cc
    (lambda (k)
      (with-exception-handler
        (lambda (e)
          (k `(fail
                (description . ,description)
                (input . ,input)
                (output . ,output)
                (who . ,procedure))))
        (lambda ()
          (let ([result (test-run-solution procedure input)])
            (unless (success-predicate result output)
              (error 'exercism-test
                "test fails"
                description
                input
                result
                output)))
          `(pass . ,description))))))

(define (test-error description procedure input)
  (call/cc
    (lambda (k)
      (with-exception-handler
        (lambda (e) (k `(pass . ,description)))
        (lambda ()
          (test-run-solution procedure input)
          `(fail
             (description . ,description)
             (input . ,input)
             (output . error)
             (who . ,procedure)))))))

(define (run-test-suite tests . query)
  (for-each
    (lambda (field)
      (unless (and (symbol? field) (memq field test-fields))
        (error 'run-test-suite
          (format "~a not in ~a" field test-fields))))
    query)
  (let-values ([(passes failures)
                (partition
                  (lambda (result) (eq? 'pass (car result)))
                  (map (lambda (test) (test)) tests))])
    (cond
      [(null? failures) (format #t "~%Well done!~%~%") 'success]
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
                 (format #t "  - ~a: ~a~%" (car info) (cdr info))))
             query))
         failures)
       (newline)
       'failure])))

(define (multiset-equal? xs ys)
  (equal? (list-sort < xs) (list-sort < ys)))

(define (test . args)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "no factors" multiset-equal? factorize '(1)
          '()))
      (lambda ()
        (test-success "prime number" multiset-equal? factorize '(2)
          '(2)))
      (lambda ()
        (test-success "square of a prime" multiset-equal? factorize
          '(9) '(3 3)))
      (lambda ()
        (test-success "cube of a prime" multiset-equal? factorize
          '(8) '(2 2 2)))
      (lambda ()
        (test-success "product of primes and non-primes"
          multiset-equal? factorize '(12) '(2 2 3)))
      (lambda ()
        (test-success "product of primes" multiset-equal? factorize
          '(901255) '(5 17 23 461)))
      (lambda ()
        (test-success "factors include a large prime"
          multiset-equal? factorize '(93819012551)
          '(11 9539 894119))))
    args))

