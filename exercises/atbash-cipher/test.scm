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
      (test-success "encode yes" equal? encode '("yes") "bvh"))
    (lambda ()
      (test-success "encode no" equal? encode '("no") "ml"))
    (lambda ()
      (test-success "encode OMG" equal? encode '("OMG") "lnt"))
    (lambda ()
      (test-success "encode spaces" equal? encode '("O M G")
		    "lnt"))
    (lambda ()
      (test-success "encode mindblowingly" equal? encode
		    '("mindblowingly") "nrmwy oldrm tob"))
    (lambda ()
      (test-success "encode numbers" equal? encode
		    '("Testing,1 2 3, testing.") "gvhgr mt123 gvhgr mt"))
    (lambda ()
      (test-success "encode deep thought" equal? encode
		    '("Truth is fiction.") "gifgs rhurx grlm"))
    (lambda ()
      (test-success "encode all the letters" equal? encode
		    '("The quick brown fox jumps over the lazy dog.")
		    "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"))
    (lambda ()
      (test-success "decode exercism" equal? decode '("vcvix rhn")
		    "exercism"))
    (lambda ()
      (test-success "decode a sentence" equal? decode
		    '("zmlyh gzxov rhlug vmzhg vkkrm thglm v")
		    "anobstacleisoftenasteppingstone"))
    (lambda ()
      (test-success "decode numbers" equal? decode
		    '("gvhgr mt123 gvhgr mt") "testing123testing"))
    (lambda ()
      (test-success "decode all the letters" equal? decode
		    '("gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt")
		    "thequickbrownfoxjumpsoverthelazydog"))
    (lambda ()
      (test-success "decode with too many spaces" equal? decode
		    '("vc vix    r hn") "exercism"))
    (lambda ()
      (test-success "decode with no spaces" equal? decode
		    '("zmlyhgzxovrhlugvmzhgvkkrmthglmv")
		    "anobstacleisoftenasteppingstone")))
   args))

