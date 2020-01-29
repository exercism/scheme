(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 =
                 collatz
                 '(,(cdar (lookup 'input test)))
                 ,(lookup 'expected test)))

(define success-case?
  (lambda (test)
    (number? (lookup 'expected test))))

(define (spec->tests spec)
  (map parse-test
       (filter success-case?
               (lookup 'cases spec))))

(let ([spec (get-test-specification 'collatz-conjecture)])
  (put-problem!
   'collatz-conjecture
   `((test . ,(spec->tests spec))
     (stubs collatz)
     (version . ,(lookup 'version spec))
     (skeleton . "collatz-conjecture.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism
                   'collatz-conjecture
                   '(sentence "Don't worry about validating input for this track -- all inputs will be natural numbers."))))))

