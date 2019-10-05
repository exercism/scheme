(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 equal?
                 sieve
                 '(,(cdar (lookup 'input test)))
                 ',(lookup 'expected test)))

(define (make-harder-test in-out)
  `(test-success ,(format "~a primes below ~a" (cdr in-out) (car in-out))
                 (lambda (result n)
                   (= n (length result)))
                 sieve
                 '(,(car in-out))
                 ,(cdr in-out)))

(define (spec->tests spec)
  (append (map parse-test (lookup 'cases spec))
          (map make-harder-test '((10000 . 1229)
                                  (100000 . 9592)
                                  (1000000 . 78498)))))

(let ((spec (get-test-specification 'sieve)))
  (put-problem!
   'sieve
   `((test . ,(spec->tests spec))
     (stubs sieve)
     (version . ,(lookup 'version spec))
     (skeleton . "sieve.scm")
     (solution . "example.scm")
     (hints.md . ,(splice-exercism 'sieve)))))

