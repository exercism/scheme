
(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
                   equal?
                   pascals-triangle
                   '(,(cdar (lookup 'input test)))
                   ',(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
     (define (test . args)
       (apply
         run-test-suite
         (list ,@(map parse-test
                      (lookup 'cases
                              (car
                                (lookup 'cases spec)))))
         args))))

(put-problem!
  'pascals-triangle
  `((test
      .
      ,(spec->tests (get-test-specification 'pascals-triangle)))
     (skeleton . ,"pascals-triangle.scm")
     (solution . ,"example.scm")))

