(load "test-util.ss")

(define test-cases
  `((test-success "zero steps for one" = collatz '(1) 0)
    (test-success "divide if even" = collatz '(16) 4)
    (test-success "even and odd steps" = collatz '(12) 9)
    (test-success "large number of even and odd steps" = collatz
                  '(1000000) 152)))

(run-with-cli "collatz-conjecture.scm" `(,test-cases))
