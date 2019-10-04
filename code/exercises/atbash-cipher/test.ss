
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

(let ((spec (get-test-specification 'atbash-cipher)))
  (put-problem!
   'atbash-cipher
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "atbash-cipher.scm")
     (solution . "example.scm")
     (hints.md . ,(splice-exercism 'atbash-cipher)))))
