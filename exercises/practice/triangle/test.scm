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

(define triangle)

(define test-cases
  (list
    (lambda ()
      (test-success "equilateral: 2 2 2" equal? triangle '(2 2 2) 'equilateral))
    (lambda ()
      (test-success "equilateral: 10 10 10" equal? triangle '(10 10 10) 'equilateral))
    (lambda ()
      (test-success "isosceles: 3 4 4" equal? triangle '(3 4 4) 'isosceles))
    (lambda ()
      (test-success "isosceles: 4 3 4" equal? triangle '(4 3 4) 'isosceles))
    (lambda ()
      (test-success "isosceles: 4 4 3" equal? triangle '(4 4 3) 'isosceles))
    (lambda ()
      (test-success "isosceles: 10 10 2" equal? triangle '(10 10 2) 'isosceles))
    (lambda ()
      (test-success "scalene: 3 4 5" equal? triangle '(3 4 5) 'scalene))
    (lambda ()
      (test-success "scalene: 10 11 12" equal? triangle '(10 11 12) 'scalene))
    (lambda ()
      (test-success "scalene: 5 4 2" equal? triangle '(5 4 2) 'scalene))
    (lambda ()
      (test-error "invalid: 0 0 0" triangle '(0 0 0)))
    (lambda ()
      (test-error "invalid: 3 4 -5" triangle '(3 4 -5)))
    (lambda ()
      (test-error "invalid: 1 1 3" triangle '(1 1 3)))
    (lambda ()
      (test-error "invalid: 2 4 2" triangle '(2 4 2)))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "triangle.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "triangle.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

