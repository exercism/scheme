; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/leap/canonical-data.json
; File last updated on 2026-10-21T17:03:27+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. year not divisible by 4 in common year" eqv? leap-year? '(2015) #f)

    (test-success "2. year divisible by 2, not divisible by 4 in common year" eqv? leap-year? '(1970) #f)

    (test-success "3. year divisible by 4, not divisible by 100 in leap year" eqv? leap-year? '(1996) #t)

    (test-success "4. year divisible by 4 and 5 is still a leap year" eqv? leap-year? '(1960) #t)

    (test-success "5. year divisible by 100, not divisible by 400 in common year" eqv? leap-year? '(2100) #f)

    (test-success "6. year divisible by 100 but not by 3 is still not a leap year" eqv? leap-year? '(1900) #f)

    (test-success "7. year divisible by 400 is leap year" eqv? leap-year? '(2000) #t)

    (test-success "8. year divisible by 400 but not by 125 is still a leap year" eqv? leap-year? '(2400) #t)

    (test-success "9. year divisible by 200, not divisible by 400 in common year" eqv? leap-year? '(1800) #f)
    ))

(run-with-cli "leap.scm" (list test-cases))
