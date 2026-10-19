; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/perfect-numbers/canonical-data.json
; File last updated on 2026-10-19T19:25:22+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. Smallest perfect number is classified correctly"
        eq? classify '(6) `perfect)

    (test-success "2. Medium perfect number is classified correctly"
        eq? classify '(28) `perfect)

    (test-success "3. Large perfect number is classified correctly"
        eq? classify '(33550336) `perfect)

    (test-success "4. Smallest abundant number is classified correctly"
        eq? classify '(12) `abundant)

    (test-success "5. Medium abundant number is classified correctly"
        eq? classify '(30) `abundant)

    (test-success "6. Large abundant number is classified correctly"
        eq? classify '(33550335) `abundant)

    (test-success "7. Perfect square abundant number is classified correctly"
        eq? classify '(196) `abundant)

    (test-success "8. Smallest prime deficient number is classified correctly"
        eq? classify '(2) `deficient)

    (test-success "9. Smallest non-prime deficient number is classified correctly"
        eq? classify '(4) `deficient)

    (test-success "10. Medium deficient number is classified correctly"
        eq? classify '(32) `deficient)

    (test-success "11. Large deficient number is classified correctly"
        eq? classify '(33550337) `deficient)

    (test-success "12. Edge case (no factors other than itself) is classified correctly"
        eq? classify '(1) `deficient)

    (test-error "13. Zero is rejected (as it is not a positive integer)"
        classify '(0))

    (test-error "14. Negative integer is rejected (as it is not a positive integer)"
        classify '(-1))
    ))

(run-with-cli "perfect-numbers.scm" (list test-cases))
