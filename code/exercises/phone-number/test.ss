
(define (parse-test test)
  ;;  (let ((expected (lookup 'expected test))))
  (let ((expected (lookup 'expected test)))
    (if (string? expected)
	`(lambda ()
	   (test-success ,(lookup 'description test)
			 equal?
			 clean
			 '(,(cdar (lookup 'input test)))
			 ,expected))
	`(lambda ()
	   (test-error ,(lookup 'description test)
		       clean
		       '(,(cdar (lookup 'input test))))))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases
				       (car (lookup 'cases spec)))))
       args))))

(put-problem!
  'phone-number
  `((test
      .
      ,(spec->tests (get-test-specification 'phone-number)))
     (skeleton . ,"phone-number.scm")
     (solution . ,"example.scm")))

