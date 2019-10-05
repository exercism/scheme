(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 equal?
                 convert
                 '(,(lookup-spine '(input number) test))
                 ,(lookup 'expected test)))

(let ((spec (get-test-specification 'raindrops)))
  (put-problem!
   'raindrops
   `((test . ,(map parse-test (lookup 'cases spec)))
     (stubs convert)
     (version . ,(lookup 'version spec))
     (skeleton . ,"raindrops.scm")
     (solution . ,"example.scm")
     (markdown . ,(splice-exercism 'raindrops)))))

