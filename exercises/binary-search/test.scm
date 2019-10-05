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
          (format #t "~a not in ~a" field test-fields))))
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
       (error 'test "incorrect solution")])))

(define binary-search)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "finds a value in an array with one element"
          equal? binary-search '(#(6) 6) 0))
      (lambda ()
        (test-success "finds a value in the middle of an array"
          equal? binary-search '(#(1 3 4 6 8 9 11) 6) 3))
      (lambda ()
        (test-success "finds a value at the beginning of an array"
          equal? binary-search '(#(1 3 4 6 8 9 11) 1) 0))
      (lambda ()
        (test-success "finds a value at the end of an array" equal?
          binary-search '(#(1 3 4 6 8 9 11) 11) 6))
      (lambda ()
        (test-success "finds a value in an array of odd length" equal?
          binary-search
          '(#(1 3 5 8 13 21 34 55 89 144 233 377 634) 144) 9))
      (lambda ()
        (test-success "finds a value in an array of even length" equal?
          binary-search '(#(1 3 5 8 13 21 34 55 89 144 233 377) 21)
          5))
      (lambda ()
        (test-success "identifies that a value is not included in the array"
          equal? binary-search '(#(1 3 4 6 8 9 11) 7) 'not-found))
      (lambda ()
        (test-success
          "a value smaller than the array's smallest value is not found"
          equal? binary-search '(#(1 3 4 6 8 9 11) 0) 'not-found))
      (lambda ()
        (test-success
          "a value larger than the array's largest value is not found"
          equal? binary-search '(#(1 3 4 6 8 9 11) 13) 'not-found))
      (lambda ()
        (test-success "nothing is found in an empty array" equal?
          binary-search '(#() 1) 'not-found))
      (lambda ()
        (test-success "nothing is found when the left and right bounds cross"
          equal? binary-search '(#(1 2) 0) 'not-found)))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "binary-search.scm")
      (load (cadr args)))
  (when (eq? 'failure (test 'input 'output))
    (error 'test "incorrect solution")))

