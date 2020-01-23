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

(define binary-search)

(define test-cases
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
        equal? binary-search '(#(1 2) 0) 'not-found))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "binary-search.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "binary-search.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

