(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   equal?
		   dna->rna
		   '(,(cdar (lookup 'input test)))
		   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply run-test-suite
	     (list ,@(map parse-test (lookup 'cases spec)))
	     args))))

(put-problem!
 'rna-transcription
 `((test . ,(spec->tests
	     (get-test-specification 'rna-transcription)))
   (skeleton . "rna-transcription.scm")
   (solution . "example.scm")))

