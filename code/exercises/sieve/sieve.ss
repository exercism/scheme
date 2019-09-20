(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
                   equal?
                   sieve
                   '(,(cdar (lookup 'input test)))
                   ',(lookup 'expected test))))

(define (make-harder-test in-out)
  `(lambda ()
     (test-success ,(format "~a primes below ~a" (cdr in-out) (car in-out))
                   (lambda (result n)
                     (= n (length result)))
                   sieve
                   '(,(car in-out))
                   ',(cdr in-out))))

(define (spec->tests spec)
  `(,@*test-definitions*
     (define (test . args)
       (apply
         run-test-suite
         (list ,@(map parse-test (lookup 'cases spec))
               ,@(map make-harder-test '((10000 . 1229)
                                         (100000 . 9592)
                                         (1000000 . 78498)
                                         (10000000 . 664579))))
         args))))

(put-problem!
  'sieve
  `((test . ,(spec->tests (get-test-specification 'sieve)))
     (skeleton . ,"sieve.scm")
     (solution . ,"example.scm")))

