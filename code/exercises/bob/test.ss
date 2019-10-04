(define (parse-test test)
  (let ((input (lookup 'heyBob (lookup 'input test))))
    `(lambda ()
       (test-success ,(lookup 'description test)
		     equal? response-for
		     ;; input needs to be a list. since the procedure
		     ;; response-for is called via (apply response-for arg-list)
		     '(,input)
		     ,(lookup 'expected test)))))

(define (spec->tests spec)
  `(,@*test-definitions*
     (define (test . args)
       (apply
         run-test-suite
         (list ,@(map parse-test (lookup 'cases spec)))
         args))))
(let ((spec (get-test-specification 'bob)))
  (put-problem!
   'bob
   `((test
      .
      ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . ,"bob.scm")
     (solution . ,"example.scm")
     (hints.md . ,(splice-exercism
                   'bob
                   '(sentence "For extra fun see if you can
clearly separate responsibilities in your code.
Using symbol messages can help by acting like enums or ADTs
in other languages."))))))
