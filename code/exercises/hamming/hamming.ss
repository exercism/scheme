
(define (hamming-test test)
  (let* ((out (lookup 'expected test))
	 (desc (lookup 'description test))
	 (input (lookup 'input test))
	 (strand1 (lookup 'strand1 input))
	 (strand2 (lookup 'strand2 input)))
    ;; if not number test expects error
    (if (number? out)
	`(lambda ()
	   (test-success ,desc
			 =
			 hamming-distance
			 '(,strand1 ,strand2)
			 ,out))
	`(lambda ()
	   (test-error ,desc
		       hamming-distance
		       '(,strand1 ,strand2))))))

(define (spec->tests spec) 
  `(,@*test-definitions*
    (define (test . args)
      (apply run-test-suite
	     (list ,@(map hamming-test
			  (lookup 'cases spec)))
	     args))))

(put-problem! 'hamming
	      `((test . ,(spec->tests
			  (get-test-specification 'hamming)))
		(skeleton . "hamming.scm")
		(solution . "example.scm")))

