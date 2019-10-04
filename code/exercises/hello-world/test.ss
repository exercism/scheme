(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   equal?
		   hello-world
		   '()
		   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec)))
       args))))

(let ((spec (get-test-specification 'hello-world)))
  (put-problem!
   'hello-world
   `((test
      .
      ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "hello-world.scm")
     (solution . "example.scm")
     (hints.md . ,(splice-exercism
                   'hello-world
                   '(sentence "Your solution may be a procedure that
returns the desired string or a variable whose value is that
string."))))))

