(define test-fields
  '(input
    output
    who))

(define (test-run-solution solution input)
  (if (procedure? solution)
      (apply solution input)
      solution))

(define (test-success description success-predicate procedure input output)
  (call/cc
    (lambda (k)
      (with-exception-handler
	  (lambda (e)
            (k `(fail . ((description . ,description)
                         (input . ,input)
                         (output . ,output)
                         (who . ,procedure)))))
	(lambda ()
	  (let ((result (test-run-solution procedure input)))
	    (unless (success-predicate result output)
	      (error 'exercism-test "test fails" description input result output)))
	  `(pass . ,description))))))

(define (test-error description procedure input)
  (call/cc
    (lambda (k)
      (with-exception-handler
	  (lambda (e)
	    (k `(pass . ,description)))
	(lambda ()
	  (test-run-scheme procedure input)
	  `(fail . ((description . ,description)
		    (input . ,input)
		    (output . ,output)
		    (who . ,procedure))))))))

(define (run-test-suite tests . query)
  (for-each (lambda (field)
	      (unless (and (symbol? field) (memq field test-fields))
		(error 'run-test-suite
		       (format "~a not in ~a" field test-fields))))
	    query)
  (let-values (((passes failures)
		(partition (lambda (result)
			     (eq? 'pass (car result)))
			   (map (lambda (test)
				  (test))
				tests))))
    (cond
      ((null? failures)
       (format #t "~%Well done!~%~%")
       'success)
      (else
       (format #t "~%Passed ~a/~a tests.~%~%The following test cases failed:~%~%"
	       (length passes)
	       (length tests))
       (for-each (lambda (failure)
		   (format #t "* ~a~%"
			   (cond ((assoc 'description (cdr failure))
                                  => cdr)
                                 (else (cdr failure))))
		   (for-each (lambda (field)
			       (format #t "  - '~a~%"
				       (assoc field (cdr failure))))
			     query))
		 failures)
       (newline)
       'failure))))


