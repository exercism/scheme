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

(put-problem!
 'scrabble-score
 `((test
    .
    ,(spec->tests (get-test-specification 'scrabble-score)))
   (skeleton . ,"scrabble-score.scm")
   (solution . ,"example.scm")))

