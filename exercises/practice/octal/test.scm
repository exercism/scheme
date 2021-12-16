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

(define to-decimal)

(define test-cases
  (list
    (lambda ()
      (test-success "octal 1 is decimal 1" equal? to-decimal '("1") 1))
    (lambda ()
      (test-success "octal 2 is decimal 2" equal? to-decimal '("2") 2))
    (lambda ()
      (test-success "octal 10 is decimal 8" equal? to-decimal '("10") 8))
    (lambda ()
      (test-success "octal 11 is decimal 9" equal? to-decimal '("11") 9))
    (lambda ()
      (test-success "octal 17 is deciaml 15" equal? to-decimal '("17") 15))
    (lambda ()
      (test-success "octal 130 is decimal 88" equal? to-decimal '("130") 88))
    (lambda ()
      (test-success "octal 2047 is decimal 1063" equal? to-decimal
                    '("2047") 1063))
    (lambda ()
      (test-success "octal 7777 is decimal 4095" equal? to-decimal
                    '("7777") 4095))
    (lambda ()
      (test-success "octal 1234567 is decimal 342391" equal? to-decimal
                    '("1234567") 342391))
    (lambda ()
      (test-success "invalid input is decimal 0" equal? to-decimal
                    '("carrot should be invalid") 0))
    (lambda ()
      (test-success "8 is invalid octal" equal? to-decimal '("8") 0))
    (lambda ()
      (test-success "9 is invalid octal" equal? to-decimal '("9") 0))
    (lambda ()
      (test-success "6789 is invalid octal" equal? to-decimal '("6789") 0))
    (lambda ()
      (test-success "abc1z is invalid octal" equal? to-decimal '("abc1z") 0))
    (lambda ()
      (test-success "leading zero is valid octal" equal? to-decimal
                    '("011") 9))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "octal.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "octal.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

