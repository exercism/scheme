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

(define (test . args)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "zero rows" equal? pascals-triangle '(0) '()))
      (lambda ()
        (test-success "single row" equal? pascals-triangle '(1)
          '((1))))
      (lambda ()
        (test-success "two rows" equal? pascals-triangle '(2)
          '((1) (1 1))))
      (lambda ()
        (test-success "three rows" equal? pascals-triangle '(3)
          '((1) (1 1) (1 2 1))))
      (lambda ()
        (test-success "four rows" equal? pascals-triangle '(4)
          '((1) (1 1) (1 2 1) (1 3 3 1))))
      (lambda ()
        (test-success "five rows" equal? pascals-triangle '(5)
          '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1))))
      (lambda ()
        (test-success "six rows" equal? pascals-triangle '(6)
          '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1) (1 5 10 10 5 1))))
      (lambda ()
        (test-success "ten rows" equal? pascals-triangle '(10)
          '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1) (1 5 10 10 5 1)
                (1 6 15 20 15 6 1) (1 7 21 35 35 21 7 1)
                (1 8 28 56 70 56 28 8 1) (1 9 36 84 126 126 84 36 9 1))))
      (lambda ()
        (test-success "all rows sum to power of 2"
          (lambda (n ignore)
            (null?
              (filter
                not
                (map (lambda (row) (= 1 (bitwise-bit-count (apply + row))))
                     (pascals-triangle n)))))
          (lambda (x) x) '(100) 'ignore)))
    args))

