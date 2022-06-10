(load "test-util.ss")

(define test-cases
  `((test-success
      "returns the total number of grains on the board" equal?
      total '() 18446744073709551615) (test-success "1" equal? square '(1) 1)
     (test-success "2" equal? square '(2) 2)
     (test-success "3" equal? square '(3) 4)
     (test-success "4" equal? square '(4) 8)
     (test-success "16" equal? square '(16) 32768)
     (test-success "32" equal? square '(32) 2147483648)
     (test-success "64" equal? square '(64) 9223372036854775808)
     (test-error "square 0 raises an exception" square '(0))
     (test-error
       "negative square raises an exception"
       square
       '(-1))
     (test-error
       "square greater than 64 raises an exception"
       square
       '(65))))

(run-with-cli "grains.scm" (list test-cases))

