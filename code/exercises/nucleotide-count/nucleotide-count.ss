(define (parse-test test)
  (let ((expected (lookup 'expected test))
	(in (cdar (lookup 'input test)))
	(desc (lookup 'description test)))
    (if (eq? 'error (caar expected))
	`(lambda ()
	   (test-error ,desc nucleotide-count '(,in)))
	`(lambda ()
	   (test-success ,desc
			 dna-count-eq?
			 nucleotide-count
			 '(,in)
			 '(,@(map (lambda (x) ;; make sure cars are chars not symbols
				    (cons (string-ref (symbol->string (car x)) 0)
					  (cdr x)))
				  expected)))))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (dna-count-eq? xs ys)
      (letrec ((make-list
		(lambda (x n)
		  (if (zero? n)
		      '()
		      (cons x (make-list x (- n 1))))))
	       (count->list
		(lambda (z)
		  (list-sort char<?
			     (apply append (map (lambda (x)
						  (make-list (car x) (cdr x)))
						z))))))
	(equal? (count->list xs) (count->list ys))))
    (define (test . args)
      (apply run-test-suite
	     (list ,@(map parse-test
			  (lookup 'cases
				  (cdar
				   (lookup 'cases spec)))))
	     args))))

(put-problem!
  'nucleotide-count
  `((test
      .
      ,(spec->tests (get-test-specification 'nucleotide-count)))
     (skeleton . ,"nucleotide-count.scm")
     (solution . ,"example.scm")))

