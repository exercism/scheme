(load "test-util.ss")

(define test-cases
  `((test-success "no multiples within limit" equal?
      sum-of-multiples '((3 5) 1) 0)
     (test-success "one factor has multiples within limit" equal?
       sum-of-multiples '((3 5) 4) 3)
     (test-success "more than one multiple within limit" equal?
       sum-of-multiples '((3) 7) 9)
     (test-success
       "more than one factor with multiples within limit" equal?
       sum-of-multiples '((3 5) 10) 23)
     (test-success "each multiple is only counted once" equal?
       sum-of-multiples '((3 5) 100) 2318)
     (test-success "a much larger limit" equal? sum-of-multiples
       '((3 5) 1000) 233168)
     (test-success "three factors" equal? sum-of-multiples
       '((7 13 17) 20) 51)
     (test-success "factors not relatively prime" equal?
       sum-of-multiples '((4 6) 15) 30)
     (test-success
       "some pairs of factors relatively prime and some not" equal?
       sum-of-multiples '((5 6 8) 150) 4419)
     (test-success "one factor is a multiple of another" equal?
       sum-of-multiples '((5 25) 51) 275)
     (test-success "much larger factors" equal? sum-of-multiples
       '((43 47) 10000) 2203160)
     (test-success "all numbers are multiples of 1" equal?
       sum-of-multiples '((1) 100) 4950)
     (test-success "no factors means an empty sum" equal?
       sum-of-multiples '(() 10000) 0)
     (test-success "the only multiple of 0 is 0" equal?
       sum-of-multiples '((0) 1) 0)
     (test-success
       "the factor 0 does not affect the sum of multiples of other factors"
       equal? sum-of-multiples '((3 0) 4) 3)
     (test-success
       "solutions using include-exclude must extend to cardinality greater than 3"
       equal? sum-of-multiples '((2 3 5 7 11) 10000) 39614537)))

(run-with-cli "sum-of-multiples.scm" (list test-cases))

