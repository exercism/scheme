; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/square-root/canonical-data.json
; File last updated on 2026-10-14T08:24:38+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. root of 1"
        = square-root '(1) 1)

    (test-success "2. root of 4"
        = square-root '(4) 2)

    (test-success "3. root of 25"
        = square-root '(25) 5)

    (test-success "4. root of 81"
        = square-root '(81) 9)

    (test-success "5. root of 196"
        = square-root '(196) 14)

    (test-success "6. root of 65025"
        = square-root '(65025) 255)

    ))

(run-with-cli "square-root.scm" (list test-cases))
