(load "test-util.ss")

(define test-cases
  `((test-success "no factors"
      (lambda (xs ys) (equal? (list-sort < xs) (list-sort < ys)))
      factorize '(1) '())
     (test-success "prime number"
       (lambda (xs ys) (equal? (list-sort < xs) (list-sort < ys)))
       factorize '(2) '(2))
     (test-success "square of a prime"
       (lambda (xs ys) (equal? (list-sort < xs) (list-sort < ys)))
       factorize '(9) '(3 3))
     (test-success "cube of a prime"
       (lambda (xs ys) (equal? (list-sort < xs) (list-sort < ys)))
       factorize '(8) '(2 2 2))
     (test-success "product of primes and non-primes"
       (lambda (xs ys) (equal? (list-sort < xs) (list-sort < ys)))
       factorize '(12) '(2 2 3))
     (test-success "product of primes"
       (lambda (xs ys) (equal? (list-sort < xs) (list-sort < ys)))
       factorize '(901255) '(5 17 23 461))
     (test-success "factors include a large prime"
       (lambda (xs ys) (equal? (list-sort < xs) (list-sort < ys)))
       factorize '(93819012551) '(11 9539 894119))))

(run-with-cli "prime-factors.scm" (list test-cases))

