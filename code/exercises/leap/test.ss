(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 eqv?
                 leap-year?
                 '(,(lookup 'year (lookup 'input test)))
                 ,(lookup 'expected test)))

(let ((spec (get-test-specification 'leap)))
  (put-problem!
   'leap
   `((test . ,(map parse-test (lookup 'cases spec)))
     (stubs leap-year?)
     (version . ,(lookup 'version spec))
     (skeleton . ,"leap.scm")
     (solution . ,"example.scm")
     (hints.md . ,(splice-exercism 'leap)))))

