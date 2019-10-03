(define test-fields '(input output who))

(define (test-run-solution solution input)
  (if (procedure? solution) (apply solution input) solution))

(define (test-success description success-predicate
		      procedure input output)
  (call/cc
   (lambda (k)
     (with-exception-handler
      (lambda (e)
	(k `(fail
	     (description . ,description)
	     (input . ,input)
	     (output . ,output)
	     (who . ,procedure))))
      (lambda ()
	(let ([result (test-run-solution procedure input)])
	  (unless (success-predicate result output)
	    (error 'exercism-test
		   "test fails"
		   description
		   input
		   result
		   output)))
	`(pass . ,description))))))

(define (test-error description procedure input)
  (call/cc
   (lambda (k)
     (with-exception-handler
      (lambda (e) (k `(pass . ,description)))
      (lambda ()
	(test-run-solution procedure input)
	`(fail
	  (description . ,description)
	  (input . ,input)
	  (output . error)
	  (who . ,procedure)))))))

(define (run-test-suite tests . query)
  (for-each
   (lambda (field)
     (unless (and (symbol? field) (memq field test-fields))
       (error 'run-test-suite
	      (format "~a not in ~a" field test-fields))))
   query)
  (let-values ([(passes failures)
                (partition
		 (lambda (result) (eq? 'pass (car result)))
		 (map (lambda (test) (test)) tests))])
    (cond
     [(null? failures) (format #t "~%Well done!~%~%") 'success]
     [else
      (format
       #t
       "~%Passed ~a/~a tests.~%~%The following test cases failed:~%~%"
       (length passes)
       (length tests))
      (for-each
       (lambda (failure)
	 (format
	  #t
	  "* ~a~%"
	  (cond
	   [(assoc 'description (cdr failure)) => cdr]
	   [else (cdr failure)]))
	 (for-each
	  (lambda (field)
	    (let ([info (assoc field (cdr failure))])
	      (format #t "  - ~a: ~a~%" (car info) (cdr info))))
	  query))
       failures)
      (newline)
      'failure])))

(define (test . args)
  (apply
   run-test-suite
   (list
    (lambda ()
      (test-success
       "returns the total number of grains on the board" equal?
       total '() 18446744073709551615))
    (lambda () (test-success "1" equal? square '(1) 1))
    (lambda () (test-success "2" equal? square '(2) 2))
    (lambda () (test-success "3" equal? square '(3) 4))
    (lambda () (test-success "4" equal? square '(4) 8))
    (lambda () (test-success "16" equal? square '(16) 32768))
    (lambda ()
      (test-success "32" equal? square '(32) 2147483648))
    (lambda ()
      (test-success "64" equal? square '(64) 9223372036854775808))
    (lambda ()
      (test-error "square 0 raises an exception" square '(0)))
    (lambda ()
      (test-error
       "negative square raises an exception"
       square
       '(-1)))
    (lambda ()
      (test-error
       "square greater than 64 raises an exception"
       square
       '(65))))
   args))

