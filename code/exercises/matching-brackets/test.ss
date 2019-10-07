(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 eq?
                 balanced?
                 '(,(cdar (lookup 'input test)))
                 ,(lookup 'expected test)))

(define (spec->tests spec)
  (map parse-test (lookup 'cases spec)))

(let ([spec (get-test-specification 'matching-brackets)])
  (put-problem!
   'matching-brackets
   `((test . ,(spec->tests spec))
     (stubs balanced?)
     (version . ,(lookup 'version spec))
     (skeleton . "matching-brackets.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism 'matching-brackets)))))

