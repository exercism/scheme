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
                 (format #t "  - ~a: ~a~%" (car info) (cdr info))))
             query))
         failures)
       (error 'test "incorrect solution")])))

(define pangram?)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "empty sentence" eq? pangram? '("") #f))
      (lambda ()
        (test-success "perfect lower case" eq? pangram?
          '("abcdefghijklmnopqrstuvwxyz") #t))
      (lambda ()
        (test-success "only lower case" eq? pangram?
          '("the quick brown fox jumps over the lazy dog") #t))
      (lambda ()
        (test-success "missing the letter 'x'" eq? pangram?
          '("a quick movement of the enemy will jeopardize five gunboats")
          #f))
      (lambda ()
        (test-success "missing the letter 'h'" eq? pangram?
          '("five boxing wizards jump quickly at it") #f))
      (lambda ()
        (test-success "with underscores" eq? pangram?
          '("the_quick_brown_fox_jumps_over_the_lazy_dog") #t))
      (lambda ()
        (test-success "with numbers" eq? pangram?
          '("the 1 quick brown fox jumps over the 2 lazy dogs") #t))
      (lambda ()
        (test-success "missing letters replaced by numbers" eq? pangram?
          '("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog") #f))
      (lambda ()
        (test-success "mixed case and punctuation" eq? pangram?
          '("\"Five quacking Zephyrs jolt my wax bed.\"") #t))
      (lambda ()
        (test-success "case insensitive" eq? pangram?
          '("the quick brown fox jumps over with lazy FX") #f)))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "pangram.scm")
      (load (cadr args)))
  (test 'input 'output))

