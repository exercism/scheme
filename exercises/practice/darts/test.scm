; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/darts/canonical-data.json
; File last updated on 2026-10-20T22:32:02+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. Missed target"
        = score '(-9 9) 0)

    (test-success "2. On the outer circle"
        = score '(0 10) 1)

    (test-success "3. On the middle circle"
        = score '(-5 0) 5)

    (test-success "4. On the inner circle"
        = score '(0 -1) 10)

    (test-success "5. Exactly on center"
        = score '(0 0) 10)

    (test-success "6. Near the center"
        = score '(-0.1 -0.1) 10)

    (test-success "7. Just within the inner circle"
        = score '(0.7 0.7) 10)

    (test-success "8. Just outside the inner circle"
        = score '(0.8 -0.8) 5)

    (test-success "9. Just within the middle circle"
        = score '(-3.5 3.5) 5)

    (test-success "10. Just outside the middle circle"
        = score '(-3.6 -3.6) 1)

    (test-success "11. Just within the outer circle"
        = score '(-7.0 7.0) 1)

    (test-success "12. Just outside the outer circle"
        = score '(7.1 -7.1) 0)

    (test-success "13. Asymmetric position between the inner and middle circles"
        = score '(0.5 -4) 5)
    ))

(run-with-cli "darts.scm" (list test-cases))
