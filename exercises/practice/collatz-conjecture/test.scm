; These tests are auto-generated with test data from: 
; https://github.com/exercism/problem-specifications/blob/main/exercises/collatz-conjecture/canonical-data.json
; File last updated on 2026-10-03T18:48:28+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "zero steps for one" = collatz '(1) 0)

    (test-success "divide if even" = collatz '(16) 4)

    (test-success "even and odd steps" = collatz '(12) 9)

    (test-success "large number of even and odd steps" = collatz '(1000000) 152)
))

(run-with-cli "collatz-conjecture.scm" (list test-cases))
