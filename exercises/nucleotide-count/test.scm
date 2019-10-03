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

(define (dna-count-eq? xs ys)
  (letrec ([make-list (lambda (x n)
                        (if (zero? n) '() (cons x (make-list x (- n 1)))))]
           [count->list (lambda (z)
                          (list-sort
			   char<?
			   (apply
			    append
			    (map (lambda (x) (make-list (car x) (cdr x)))
				 z))))])
    (equal? (count->list xs) (count->list ys))))

(define (test . args)
  (apply
   run-test-suite
   (list
    (lambda ()
      (test-success "empty strand" dna-count-eq? nucleotide-count
		    '("") '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0))))
    (lambda ()
      (test-success "can count one nucleotide in single-character input"
		    dna-count-eq? nucleotide-count '("G")
		    '((#\A . 0) (#\C . 0) (#\G . 1) (#\T . 0))))
    (lambda ()
      (test-success "strand with repeated nucleotide" dna-count-eq?
		    nucleotide-count '("GGGGGGG")
		    '((#\A . 0) (#\C . 0) (#\G . 7) (#\T . 0))))
    (lambda ()
      (test-success "strand with multiple nucleotides" dna-count-eq?
		    nucleotide-count
		    '("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
		    '((#\A . 20) (#\C . 12) (#\G . 17) (#\T . 21))))
    (lambda ()
      (test-error
       "strand with invalid nucleotides"
       nucleotide-count
       '("AGXXACT"))))
   args))

