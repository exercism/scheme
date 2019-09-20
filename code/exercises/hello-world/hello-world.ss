(define (hello-world-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   equal?
		   hello-world
		   '()
		   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply run-test-suite
	     (list ,@(map hello-world-test
			  (lookup 'cases spec)))
	     args))))

(put-problem! 'hello-world
	      `((test . ,(spec->tests
			  (get-test-specification 'hello-world)))
		(skeleton . "hello-world.scm")
		(solution . "example.scm")))








