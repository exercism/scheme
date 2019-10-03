(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   count-equal?
		   word-count
		   '(,(cdar (lookup 'input test)))
		   '(,@(map (lambda (expected)
			      (cons (symbol->string (car expected))
				    (cdr expected)))
			    (lookup 'expected test))))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (count-equal? result expected)
      (let ((get-count (if (hashtable? result)
			   (lambda (word)
			     (hashtable-ref result word 0))
			   (lambda (word)
			     (cond ((assoc word result) => cdr)
				   (else 0))))))
	(and (= (length expected)
		(hashtable-size result))
	     (fold-left (lambda (count-agrees w.c)
			  (and count-agrees
			       (= (cdr w.c)
				  (get-count (car w.c)))))
			#t
			expected))))
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec)))
       args))))

(let ((spec (get-test-specification 'word-count)))
  (put-problem!
   'word-count
   `((test . ,(spec->tests (get-test-specification 'word-count)))
     (version . ,(lookup 'version spec))
     (skeleton . "word-count.scm")
     (solution . "example.scm"))))

