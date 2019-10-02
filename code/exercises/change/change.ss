(define (parse-test test)
  `(lambda ()
     (test-success (lookup 'description test) equal? problem
       (lookup 'input test) (lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
     (define (test . args)
       (apply
         run-test-suite
         (list ,@(map parse-test (lookup 'cases spec)))
         args))))

(put-problem!
  'change
  `((test . ,(spec->tests (get-test-specification 'change)))
     (skeleton . ,"change.scm")
     (solution . ,"example.scm")))

