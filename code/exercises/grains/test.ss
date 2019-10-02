(define (parse-test test)
  (let* ((out (lookup 'expected test))
	 (desc (lookup 'description test))
	 (val (string->symbol (lookup 'property test)))
	 (in (lookup 'input test))
	 (arg (or (and ;;(not (null? in))
		       (pair? in)
		       (lookup 'square in))
		  in)))
    (if (number? out)
	(if (null? arg)
	    `(lambda ()
	       (test-success ,desc equal? ,val '() ,out))
	    `(lambda ()
	       (test-success ,desc equal? ,val '(,arg) ,out)))
	`(lambda ()
	   (test-error ,desc ,val '(,@arg))))))

(define (spec->tests spec)
  (let* ((step1 (lookup 'cases spec))
	 (test-total (cdr step1))
	 (test-square (car step1)))
    `(,@*test-definitions*
      (define (test . args)
	(apply run-test-suite
	       (list ,@(map parse-test test-total)
		     ,@(map parse-test (lookup 'cases test-square)))
	       args)))))

(put-problem!
 'grains
 `((test . ,(spec->tests (get-test-specification 'grains)))
   (skeleton . "grains.scm")
   (solution . "example.scm")
   (hints.md
    .
    ,(md-hints
      `((sentence "The tests expect an error to be reported for out of
range inputs."))))))


