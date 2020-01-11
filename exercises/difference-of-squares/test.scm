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

(define sum-of-squares)

(define difference-of-squares)

(define square-of-sum)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "square of sum 1" = square-of-sum '(1) 1))
      (lambda ()
        (test-success "square of sum 5" = square-of-sum '(5) 225))
      (lambda ()
        (test-success "square of sum 100" = square-of-sum '(100)
          25502500))
      (lambda ()
        (test-success "sum of squares 1" = sum-of-squares '(1) 1))
      (lambda ()
        (test-success "sum of squares 5" = sum-of-squares '(5) 55))
      (lambda ()
        (test-success "sum of squares 100" = sum-of-squares '(100)
          338350))
      (lambda ()
        (test-success "difference of squares 1" =
          difference-of-squares '(1) 0))
      (lambda ()
        (test-success "difference of squares 5" =
          difference-of-squares '(5) 170))
      (lambda ()
        (test-success "difference of squares 100" =
          difference-of-squares '(100) 25164150)))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "difference-of-squares.scm")
      (load (cadr args)))
  (test 'input 'output))

