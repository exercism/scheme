(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
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
                   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test
                    (apply append
                           (map (lookup-partial 'cases)
                                (map cdr
                                     (lookup 'cases
                                             (get-test-specification
                                              'difference-of-squares)))))))
       args))))

(let ((spec (get-test-specification 'difference-of-squares)))
  (put-problem!
   'difference-of-squares
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . ,"difference-of-squares.scm")
     (solution . ,"example.scm")
     (hints.md . ,(splice-exercism 'difference-of-squares)))))

