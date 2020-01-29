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

(define pascals-triangle)

(define test-cases
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
              (1 8 28 56 70 56 28 8 1) (1 9 36 84 126 126 84 36 9 1))))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "pascals-triangle.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "pascals-triangle.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

