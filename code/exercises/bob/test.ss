(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 equal? response-for
                 '(,(lookup 'heyBob (lookup 'input test)))
                 ,(lookup 'expected test)))

(define (spec->tests spec)
  (map parse-test (lookup 'cases spec)))

(let ((spec (get-test-specification 'bob)))
  (put-problem!
   'bob
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "bob.scm")
     (solution . "example.scm")
     (stubs response-for)
     (markdown . ,(splice-exercism 'bob)))))
