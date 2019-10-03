(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   equal?
		   convert
		   '(,(lookup-spine '(input number) test))
		   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec)))
       args))))

(put-problem!
 'raindrops
 `((test
    .
    ,(spec->tests (get-test-specification 'raindrops)))
   (skeleton . ,"raindrops.scm")
   (solution . ,"example.scm")))

