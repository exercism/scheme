(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   equal?
		   two-fer
		   ,(let ((input (cdar (lookup 'input test))))
		      (if (null? input)
			  ''()
			  `'(,input)))
		   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
     (define (test . args)
       (apply
         run-test-suite
         (list ,@(map parse-test (lookup 'cases spec)))
         args))))

(put-problem!
  'two-fer
  `((test . ,(spec->tests (get-test-specification 'two-fer)))
     (skeleton . ,"two-fer.scm")
     (solution . ,"example.scm")))

