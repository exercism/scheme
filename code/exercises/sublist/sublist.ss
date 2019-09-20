(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
                   eq?
                   sublist
                   '(,@(map cdr (lookup 'input test)))
                   ',(string->symbol
                       (lookup 'expected test)))))

(define (spec->tests spec)
  `(,@*test-definitions*
     (define (test . args)
       (apply
         run-test-suite
         (list ,@(map parse-test (lookup 'cases spec)))
         args))))

(put-problem!
  'sublist
  `((test . ,(spec->tests (get-test-specification 'sublist)))
     (skeleton . ,"sublist.scm")
     (solution . ,"example.scm")))

