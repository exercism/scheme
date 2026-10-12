; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/nth-prime/canonical-data.json
; File last updated on 2026-10-12T22:10:59+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. first prime"
        = prime '(1) 2)

    (test-success "2. second prime"
        = prime '(2) 3)

    (test-success "3. sixth prime"
        = prime '(6) 13)

    (test-success "4. big prime"
        = prime '(10001) 104743)

    (test-error "5. there is no zeroth prime"
        prime '(0))

    ))

(run-with-cli "nth-prime.scm" (list test-cases))
