; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/grains/canonical-data.json
; File last updated on 2026-10-21T17:06:34+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. grains on square 1" equal? square '(1) 1)

    (test-success "2. grains on square 2" equal? square '(2) 2)

    (test-success "3. grains on square 3" equal? square '(3) 4)

    (test-success "4. grains on square 4" equal? square '(4) 8)

    (test-success "5. grains on square 16" equal? square '(16) 32768)

    (test-success "6. grains on square 32" equal? square '(32) 2147483648)

    (test-success "7. grains on square 64" equal? square '(64) 9223372036854775808)

    (test-error "8. square 0 is invalid" square '(0))

    (test-error "9. negative square is invalid" square '(-1))

    (test-error "10. square greater than 64 is invalid" square '(65))

    (test-success "11. returns the total number of grains on the board" equal? total '() 18446744073709551615)
    ))

(run-with-cli "grains.scm" (list test-cases))
