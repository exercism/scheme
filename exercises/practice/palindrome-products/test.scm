; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/palindrome-products/canonical-data.json
; File last updated on 2026-10-13T11:41:05+00:00

(load "test-util.ss")

(define (smallest-values min-factor max-factor)
  (call-with-values (lambda () (smallest min-factor max-factor)) list))

(define (largest-values min-factor max-factor)
  (call-with-values (lambda () (largest min-factor max-factor)) list))

(define test-cases
  `(
    (test-success "1. find the smallest palindrome from single digit factors"
        equal? smallest-values '(1 9)
        '(1 ((1 1))))
    (test-success "2. find the largest palindrome from single digit factors"
        equal? largest-values '(1 9)
        '(9 ((1 9) (3 3))))
    (test-success "3. find the smallest palindrome from double digit factors"
        equal? smallest-values '(10 99)
        '(121 ((11 11))))
    (test-success "4. find the largest palindrome from double digit factors"
        equal? largest-values '(10 99)
        '(9009 ((91 99))))
    (test-success "5. find the smallest palindrome from triple digit factors"
        equal? smallest-values '(100 999)
        '(10201 ((101 101))))
    (test-success "6. find the largest palindrome from triple digit factors"
        equal? largest-values '(100 999)
        '(906609 ((913 993))))
    (test-success "7. find the smallest palindrome from four digit factors"
        equal? smallest-values '(1000 9999)
        '(1002001 ((1001 1001))))
    (test-success "8. find the largest palindrome from four digit factors"
        equal? largest-values '(1000 9999)
        '(99000099 ((9901 9999))))
    (test-success "9. empty result for smallest if no palindrome in the range"
        equal? smallest-values '(1002 1003)
        '(#f ()))
    (test-success "10. empty result for largest if no palindrome in the range"
        equal? largest-values '(15 15)
        '(#f ()))
    (test-error "11. error result for smallest if min is more than max"
        smallest-values '(10000 1))
    (test-error "12. error result for largest if min is more than max"
        largest-values '(2 1))
    (test-success "13. smallest product does not use the smallest factor"
        equal? smallest-values '(3215 4000)
        '(10988901 ((3297 3333))))
    ))

(run-with-cli "palindrome-products.scm" (list test-cases))
