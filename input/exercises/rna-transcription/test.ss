(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 equal?
                 dna->rna
                 '(,(cdar (lookup 'input test)))
                 ,(lookup 'expected test)))

(let ((spec (get-test-specification 'rna-transcription)))
  (put-problem!
   'rna-transcription
   `((test . ,(map parse-test (lookup 'cases spec)))
     (stubs dna->rna)
     (version . ,(lookup 'version spec))
     (skeleton . "rna-transcription.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism 'rna-transcription)))))

