(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 (lambda (xs ys)
                   (equal? (list-sort < xs)
                           (list-sort < ys)))
                 factorize
                 '(,(cdar (lookup 'input test)))
                 ',(lookup 'expected test)))

(define (spec->tests spec)
  (map parse-test
       (lookup 'cases
               (car
                (lookup 'cases spec)))))

(let ((spec (get-test-specification 'prime-factors)))
  (put-problem!
   'prime-factors
   `((test . ,(spec->tests spec))
     (stubs factorize)
     (version . ,(lookup 'version spec))
     (skeleton . ,"prime-factors.scm")
     (solution . ,"example.scm")
     (markdown . ,(splice-exercism 'prime-factors)))))

