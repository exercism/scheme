(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   eqv?
		   leap-year?
		   '(,(lookup 'year (lookup 'input test)))
		   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
     (define (test . args)
       (apply
         run-test-suite
         (list ,@(map parse-test (lookup 'cases spec)))
         args))))

(put-problem!
  'leap
  `((test . ,(spec->tests (get-test-specification 'leap)))
     (skeleton . ,"leap.scm")
     (solution . ,"example.scm")))

