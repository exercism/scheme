(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   =
		   ,(case (lookup 'property test)
		      (("sumOfSquares") 'sum-of-squares)
		      (("differenceOfSquares") 'difference-of-squares)
		      (("squareOfSum") 'square-of-sum))
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

(put-problem!
  'difference-of-squares
  `((test
      .
      ,(spec->tests
         (get-test-specification 'difference-of-squares)))
     (skeleton . ,"difference-of-squares.scm")
     (solution . ,"example.scm")))

