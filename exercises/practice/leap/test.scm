(load "test-util.ss")

(define test-cases
  `((test-success "year not divisible by 4 in common year"
      eqv? leap-year? '(2015) #f)
     (test-success
       "year divisible by 2, not divisible by 4 in common year"
       eqv? leap-year? '(1970) #f)
     (test-success
       "year divisible by 4, not divisible by 100 in leap year"
       eqv? leap-year? '(1996) #t)
     (test-success
       "year divisible by 4 and 5 is still a leap year" eqv?
       leap-year? '(1960) #t)
     (test-success
       "year divisible by 100, not divisible by 400 in common year"
       eqv? leap-year? '(2100) #f)
     (test-success
       "year divisible by 100 but not by 3 is still not a leap year"
       eqv? leap-year? '(1900) #f)
     (test-success "year divisible by 400 in leap year" eqv?
       leap-year? '(2000) #t)
     (test-success
       "year divisible by 400 but not by 125 is still a leap year"
       eqv? leap-year? '(2400) #t)
     (test-success
       "year divisible by 200, not divisible by 400 in common year"
       eqv? leap-year? '(1800) #f)))

(run-with-cli "leap.scm" (list test-cases))

