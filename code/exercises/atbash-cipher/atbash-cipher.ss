
(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   equal?
		   ,(string->symbol
		      (lookup 'property test))
		   '(,(cdar (lookup 'input test)))
		   ;; note it's just input that needs to be list
		   ,(lookup 'expected test))))

(define (spec->tests spec)
  (let* ((cases (apply append
		       (map (lookup-partial 'cases)
			    (lookup 'cases spec)))))
    `(,@*test-definitions*
     (define (test . args)
       (apply run-test-suite
	      (list ,@(map parse-test cases))
	      args)))))

(put-problem!
  'atbash-cipher
  `((test
      .
      ,(spec->tests (get-test-specification 'atbash-cipher)))
     (skeleton . "atbash-cipher.scm")
     (solution . "example.scm")))
