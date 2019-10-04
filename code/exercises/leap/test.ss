(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
                   eqv?
                   leap-year?
                   '(,(lookup 'year (lookup 'input test)))
                   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec)))
       args))))

(let ((spec (get-test-specification 'leap)))
  (put-problem!
   'leap
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . ,"leap.scm")
     (solution . ,"example.scm")
     (hints.md . ,(splice-exercism 'leap)))))

