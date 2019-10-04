(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   =
		   score
		   '(,(cdar (lookup 'input test)))
		   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec)))
       args))))

(let ((spec (get-test-specification 'scrabble-score)))
  (put-problem!
   'scrabble-score
   `((test
      .
      ,(spec->tests spec))
     (version . ,(lookup 'version spec))   
     (skeleton . "scrabble-score.scm")
     (solution . "example.scm")
     (hints.md . ,(splice-exercism 'scrabble-score)))))


