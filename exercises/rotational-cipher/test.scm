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

(define rotate)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "rotate a by 0, same output as input" equal?
          rotate '("a" 0) "a"))
      (lambda ()
        (test-success "rotate a by 1" equal? rotate '("a" 1) "b"))
      (lambda ()
        (test-success "rotate a by 26, same output as input" equal?
          rotate '("a" 26) "a"))
      (lambda ()
        (test-success "rotate m by 13" equal? rotate '("m" 13) "z"))
      (lambda ()
        (test-success "rotate n by 13 with wrap around alphabet"
          equal? rotate '("n" 13) "a"))
      (lambda ()
        (test-success "rotate capital letters" equal? rotate
          '("OMG" 5) "TRL"))
      (lambda ()
        (test-success "rotate spaces" equal? rotate '("O M G" 5)
          "T R L"))
      (lambda ()
        (test-success "rotate numbers" equal? rotate
          '("Testing 1 2 3 testing" 4) "Xiwxmrk 1 2 3 xiwxmrk"))
      (lambda ()
        (test-success "rotate punctuation" equal? rotate
          '("Let's eat, Grandma!" 21) "Gzo'n zvo, Bmviyhv!"))
      (lambda ()
        (test-success "rotate all letters" equal? rotate
          '("The quick brown fox jumps over the lazy dog." 13)
          "Gur dhvpx oebja sbk whzcf bire gur ynml qbt.")))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "rotational-cipher.scm")
      (load (cadr args)))
  (when (eq? 'failure (test 'input 'output))
    (error 'test "incorrect solution")))

