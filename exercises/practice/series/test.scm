; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/series/canonical-data.json
; File last updated on 2026-10-13T03:05:35+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. slices of one from one"
        equal? slices '("1" 1)
        '("1"))
    (test-success "2. slices of one from two"
        equal? slices '("12" 1)
        '("1" "2"))
    (test-success "3. slices of two"
        equal? slices '("35" 2)
        '("35"))
    (test-success "4. slices of two overlap"
        equal? slices '("9142" 2)
        '("91" "14" "42"))
    (test-success "5. slices can include duplicates"
        equal? slices '("777777" 3)
        '("777" "777" "777" "777"))
    (test-success "6. slices of a long series"
        equal? slices '("918493904243" 5)
        '("91849" "18493" "84939" "49390" "93904" "39042" "90424" "04243"))
    (test-error "7. slice length is too large"
        slices '("12345" 6))
    (test-error "8. slice length is way too large"
        slices '("12345" 42))
    (test-error "9. slice length cannot be zero"
        slices '("12345" 0))
    (test-error "10. slice length cannot be negative"
        slices '("123" -1))
    (test-error "11. empty series is invalid"
        slices '("" 1))
    ))

(run-with-cli "series.scm" (list test-cases))
