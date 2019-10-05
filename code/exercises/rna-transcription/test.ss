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

(let ((spec (get-test-specification 'rna-transcription)))
  (put-problem!
   'rna-transcription
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "rna-transcription.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism 'rna-transcription)))))

