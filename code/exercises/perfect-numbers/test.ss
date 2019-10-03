(define (parse-test test)
  (let ((expected (lookup 'expected test)))
    (if (pair? expected)
        `(lambda ()
           (test-error ,(lookup 'description test)
                       classify
                       '(,(cdar (lookup 'input test)))))
        `(lambda ()
           (test-success ,(lookup 'description test)
                         eq?
                         classify
                         '(,(cdar (lookup 'input test)))
                         ',(string->symbol expected))))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test
                    (apply append
                           (map (lookup-partial 'cases)
                                (lookup 'cases spec)))))
       args))))

(put-problem!
 'perfect-numbers
 `((test
    .
    ,(spec->tests (get-test-specification 'perfect-numbers)))
   (skeleton . ,"perfect-numbers.scm")
   (solution . ,"example.scm")))

