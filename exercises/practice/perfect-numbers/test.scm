(load "test-util.ss")

(define test-cases
  `((test-success
      "Smallest perfect number is classified correctly" eq?
      classify '(6) 'perfect)
     (test-success
       "Medium perfect number is classified correctly" eq? classify
       '(28) 'perfect)
     (test-success "Large perfect number is classified correctly"
       eq? classify '(33550336) 'perfect)
     (test-success
       "Smallest abundant number is classified correctly" eq?
       classify '(12) 'abundant)
     (test-success
       "Medium abundant number is classified correctly" eq?
       classify '(30) 'abundant)
     (test-success
       "Large abundant number is classified correctly" eq? classify
       '(33550335) 'abundant)
     (test-success
       "Smallest prime deficient number is classified correctly"
       eq? classify '(2) 'deficient)
     (test-success
       "Smallest non-prime deficient number is classified correctly"
       eq? classify '(4) 'deficient)
     (test-success
       "Medium deficient number is classified correctly" eq?
       classify '(32) 'deficient)
     (test-success
       "Large deficient number is classified correctly" eq?
       classify '(33550337) 'deficient)
     (test-success
       "Edge case (no factors other than itself) is classified correctly"
       eq? classify '(1) 'deficient)
     (test-error
       "Zero is rejected (not a natural number)"
       classify
       '(0))
     (test-error
       "Negative integer is rejected (not a natural number)"
       classify
       '(-1))))

(run-with-cli "perfect-numbers.scm" (list test-cases))

