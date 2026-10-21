; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/pascals-triangle/canonical-data.json
; File last updated on 2026-10-21T17:51:04+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. zero rows"
        equal? pascals-triangle '(0) '())

    (test-success "2. single row"
        equal? pascals-triangle '(1) '((1)))

    (test-success "3. two rows"
        equal? pascals-triangle '(2) '((1) (1 1)))

    (test-success "4. three rows"
        equal? pascals-triangle '(3) '((1) (1 1) (1 2 1)))

    (test-success "5. four rows"
        equal? pascals-triangle '(4) '((1) (1 1) (1 2 1) (1 3 3 1)))

    (test-success "6. five rows"
        equal? pascals-triangle '(5) '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1)))

    (test-success "7. six rows"
        equal? pascals-triangle '(6) '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1) (1 5 10 10 5 1)))

    (test-success "8. ten rows"
        equal? pascals-triangle '(10) '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1) (1 5 10 10 5 1) (1 6 15 20 15 6 1) (1 7 21 35 35 21 7 1) (1 8 28 56 70 56 28 8 1) (1 9 36 84 126 126 84 36 9 1)))
    ))

(run-with-cli "pascals-triangle.scm" (list test-cases))
