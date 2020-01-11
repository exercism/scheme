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

(define change)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "single coin change"
          (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
          change '(25 (1 5 10 25 100)) '(25)))
      (lambda ()
        (test-success "multiple coin change"
          (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
          change '(15 (1 5 10 25 100)) '(5 10)))
      (lambda ()
        (test-success "change with Lilliputian Coins"
          (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
          change '(23 (1 4 15 20 50)) '(4 4 15)))
      (lambda ()
        (test-success "change with Lower Elbonia Coins"
          (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
          change '(63 (1 5 10 21 25)) '(21 21 21)))
      (lambda ()
        (test-success "large target values"
          (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
          change '(999 (1 2 5 10 20 50 100))
          '(2 2 5 20 20 50 100 100 100 100 100 100 100 100 100)))
      (lambda ()
        (test-success "possible change without unit coins available"
          (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
          change '(21 (2 5 10 20 50)) '(2 2 2 5 10)))
      (lambda ()
        (test-success "another possible change without unit coins available"
          (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
          change '(27 (4 5)) '(4 4 4 5 5 5)))
      (lambda ()
        (test-success "no coins make 0 change"
          (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
          change '(0 (1 5 10 21 25)) '()))
      (lambda ()
        (test-error
          "error testing for change smaller than the smallest of coins"
          change
          '(3 (5 10))))
      (lambda ()
        (test-error
          "error if no combination can add up to target"
          change
          '(94 (5 10))))
      (lambda ()
        (test-error
          "cannot find negative change values"
          change
          '(-5 (1 2 5)))))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "change.scm")
      (load (cadr args)))
  (test 'input 'output))

