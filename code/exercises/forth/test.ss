
(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 equal?
                 forth
                 '(,(cdar (lookup 'input test)))
                 ,(lookup 'expected test)))

(define (spec->tests spec)
  (map parse-test
       (apply append
              (map (lookup-partial 'cases)
                   (lookup 'cases
                           (get-test-specification 'forth))))))

(let ([spec (get-test-specification 'forth)])
  (put-problem!
   'forth
   `((test . ,(spec->tests spec))
     (stubs forth)
     (version . ,(lookup 'version spec))
     (skeleton . "forth.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism 'forth)))))

