(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 =
                 score
                 '(,(cdar (lookup 'input test)))
                 ,(lookup 'expected test)))

(let ((spec (get-test-specification 'scrabble-score)))
  (put-problem!
   'scrabble-score
   `((test . ,(map parse-test (lookup 'cases spec)))
     (stubs score)
     (version . ,(lookup 'version spec))   
     (skeleton . "scrabble-score.scm")
     (solution . "example.scm")
     (hints.md . ,(splice-exercism 'scrabble-score)))))


