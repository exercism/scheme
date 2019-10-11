(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 =
                 ,(let ((proc (lookup 'property test)))
                    (cond ((string=? proc "sumOfSquares")
                           'sum-of-squares)
                          ((string=? proc "differenceOfSquares")
                           'difference-of-squares)
                          ((string=? proc "squareOfSum")
                           'square-of-sum)
                          (else (error 'parse-test "oops" proc))))
                 '(,(cdar (lookup 'input test)))
                 ,(lookup 'expected test)))

(define (spec->tests spec)
  (map parse-test
       (apply append
              (map (lookup 'cases)
                   (map cdr
                        (lookup 'cases
                                (get-test-specification
                                 'difference-of-squares)))))))

(let ((spec (get-test-specification 'difference-of-squares)))
  (put-problem!
   'difference-of-squares
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "difference-of-squares.scm")
     (solution . "example.scm")
     (stubs sum-of-squares difference-of-squares square-of-sum)
     (markdown . ,(splice-exercism 'difference-of-squares)))))

