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
       'failure])))

(define (test . args)
  (apply
    run-test-suite
    (list
     (lambda ()
       (test-success "stating something" equal? response-for
         '("Tom-ay-to, tom-aaaah-to.") "Whatever."))
     (lambda ()
       (test-success "shouting" equal? response-for '("WATCH OUT!")
         "Whoa, chill out!"))
     (lambda ()
       (test-success "shouting gibberish" equal? response-for
         '("FCECDFCAAB") "Whoa, chill out!"))
     (lambda ()
       (test-success "asking a question" equal? response-for
         '("Does this cryogenic chamber make me look fat?") "Sure."))
     (lambda ()
       (test-success "asking a numeric question" equal?
         response-for '("You are, what, like 15?") "Sure."))
     (lambda ()
       (test-success "asking gibberish" equal? response-for
         '("fffbbcbeab?") "Sure."))
     (lambda ()
       (test-success "talking forcefully" equal? response-for
         '("Let's go make out behind the gym!") "Whatever."))
     (lambda ()
       (test-success "using acronyms in regular speech" equal? response-for
         '("It's OK if you don't want to go to the DMV.")
         "Whatever."))
     (lambda ()
       (test-success "forceful question" equal? response-for
         '("WHAT THE HELL WERE YOU THINKING?")
         "Calm down, I know what I'm doing!"))
     (lambda ()
       (test-success "shouting numbers" equal? response-for
         '("1, 2, 3 GO!") "Whoa, chill out!"))
     (lambda ()
       (test-success "no letters" equal? response-for '("1, 2, 3")
         "Whatever."))
     (lambda ()
       (test-success "question with no letters" equal? response-for
         '("4?") "Sure."))
     (lambda ()
       (test-success "shouting with special characters" equal? response-for
         '("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")
         "Whoa, chill out!"))
     (lambda ()
       (test-success "shouting with no exclamation mark" equal?
         response-for '("I HATE THE DMV") "Whoa, chill out!"))
     (lambda ()
       (test-success "statement containing question mark" equal? response-for
         '("Ending with ? means a question.") "Whatever."))
     (lambda ()
       (test-success "non-letters with question" equal?
         response-for '(":) ?") "Sure."))
     (lambda ()
       (test-success "prattling on" equal? response-for
         '("Wait! Hang on. Are you going to be OK?") "Sure."))
     (lambda ()
       (test-success "silence" equal? response-for '("")
         "Fine. Be that way!"))
     (lambda ()
       (test-success "prolonged silence" equal? response-for
         '("          ") "Fine. Be that way!"))
     (lambda ()
       (test-success "alternate silence" equal? response-for
         '("\t\t\t\t\t\t\t\t\t\t") "Fine. Be that way!"))
     (lambda ()
       (test-success "multiple line question" equal? response-for
         '("\nDoes this cryogenic chamber make me look fat?\nNo.")
         "Whatever."))
     (lambda ()
       (test-success "starting with whitespace" equal? response-for
         '("         hmmmmmmm...") "Whatever."))
     (lambda ()
       (test-success "ending with whitespace" equal? response-for
         '("Okay if like my  spacebar  quite a bit?   ") "Sure."))
     (lambda ()
       (test-success "other whitespace" equal? response-for
         '("\n\r \t") "Fine. Be that way!"))
     (lambda ()
       (test-success "non-question ending with whitespace" equal? response-for
         '("This is a statement ending with whitespace      ")
         "Whatever.")))
    args))

