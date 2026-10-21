; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/difference-of-squares/canonical-data.json
; File last updated on 2026-10-21T17:07:44+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. square of sum 1" = square-of-sum '(1) 1)

    (test-success "2. square of sum 5" = square-of-sum '(5) 225)

    (test-success "3. square of sum 100" = square-of-sum '(100) 25502500)

    (test-success "4. sum of squares 1" = sum-of-squares '(1) 1)

    (test-success "5. sum of squares 5" = sum-of-squares '(5) 55)

    (test-success "6. sum of squares 100" = sum-of-squares '(100) 338350)

    (test-success "7. difference of squares 1" = difference-of-squares '(1) 0)

    (test-success "8. difference of squares 5" = difference-of-squares '(5) 170)

    (test-success "9. difference of squares 100" = difference-of-squares '(100) 25164150)
    ))

(run-with-cli "difference-of-squares.scm" (list test-cases))
