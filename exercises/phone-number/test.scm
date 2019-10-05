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

(define clean)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "cleans the number" equal? clean
          '("(223) 456-7890") "2234567890"))
      (lambda ()
        (test-success "cleans numbers with dots" equal? clean
          '("223.456.7890") "2234567890"))
      (lambda ()
        (test-success "cleans numbers with multiple spaces" equal?
          clean '("223 456   7890   ") "2234567890"))
      (lambda ()
        (test-error "invalid when 9 digits" clean '("123456789")))
      (lambda ()
        (test-error
          "invalid when 11 digits does not start with a 1"
          clean
          '("22234567890")))
      (lambda ()
        (test-success "valid when 11 digits and starting with 1"
          equal? clean '("12234567890") "2234567890"))
      (lambda ()
        (test-success
          "valid when 11 digits and starting with 1 even with punctuation"
          equal? clean '("+1 (223) 456-7890") "2234567890"))
      (lambda ()
        (test-error
          "invalid when more than 11 digits"
          clean
          '("321234567890")))
      (lambda ()
        (test-error "invalid with letters" clean '("123-abc-7890")))
      (lambda ()
        (test-error
          "invalid with punctuations"
          clean
          '("123-@:!-7890")))
      (lambda ()
        (test-error
          "invalid if area code starts with 0"
          clean
          '("(023) 456-7890")))
      (lambda ()
        (test-error
          "invalid if area code starts with 1"
          clean
          '("(123) 456-7890")))
      (lambda ()
        (test-error
          "invalid if exchange code starts with 0"
          clean
          '("(223) 056-7890")))
      (lambda ()
        (test-error
          "invalid if exchange code starts with 1"
          clean
          '("(223) 156-7890")))
      (lambda ()
        (test-error
          "invalid if area code starts with 0 on valid 11-digit number"
          clean
          '("1 (023) 456-7890")))
      (lambda ()
        (test-error
          "invalid if area code starts with 1 on valid 11-digit number"
          clean
          '("1 (123) 456-7890")))
      (lambda ()
        (test-error
          "invalid if exchange code starts with 0 on valid 11-digit number"
          clean
          '("1 (223) 056-7890")))
      (lambda ()
        (test-error
          "invalid if exchange code starts with 1 on valid 11-digit number"
          clean
          '("1 (223) 156-7890"))))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "phone-number.scm")
      (load (cadr args)))
  (when (eq? 'failure (test 'input 'output))
    (error 'test "incorrect solution")))

