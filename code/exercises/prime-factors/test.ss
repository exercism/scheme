(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
                   multiset-equal?
                   factorize
                   '(,(cdar (lookup 'input test)))
                   ',(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (multiset-equal? xs ys)
      (equal? (list-sort < xs)
              (list-sort < ys)))
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test
                    (lookup 'cases
                            (car
                             (lookup 'cases spec)))))
       args))))

(put-problem!
 'prime-factors
 `((test
    .
    ,(spec->tests (get-test-specification 'prime-factors)))
   (skeleton . ,"prime-factors.scm")
   (solution . ,"example.scm")))

