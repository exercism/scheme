(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   (lambda (result expected)
		     (and (= (length expected)
			     (hashtable-size result))
			  (fold-left (lambda (count-agrees w.c)
				       (and count-agrees
					    (= (cdr w.c)
					       (hashtable-ref result
							      (car w.c)
							      0))))
				     #t
				     expected)))
		   word-count
		   '(,(cdar (lookup 'input test)))
		   '(,@(map (lambda (expected)
			      (cons (symbol->string (car expected))
				    (cdr expected)))
			    (lookup 'expected test))))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec)))
       args))))

(put-problem!
  'word-count
  `((test
      .
      ,(spec->tests (get-test-specification 'word-count)))
     (skeleton . ,"word-count.scm")
     (solution . ,"example.scm")))

