
(define (leap-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   eq?
		   leap-year?
		   '(,(lookup-spine '(input year) test))
		   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply run-test-suite
	     (list ,@(map leap-test
			  (lookup 'cases spec)))
	     args))))

(put-problem! 'leap
	      `((test . ,(spec->tests
			  (get-test-specification 'leap)))
		(skeleton . "leap-year.scm")
		(solution . "example.scm")))
