; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/largest-series-product/canonical-data.json
; File last updated on 2026-10-12T09:23:14+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. finds the largest product if span equals length"
        = largest-product '("29" 2)
        18)
    (test-success "2. can find the largest product of 2 with numbers in order"
        = largest-product '("0123456789" 2)
        72)
    (test-success "3. can find the largest product of 2"
        = largest-product '("576802143" 2)
        48)
    (test-success "4. can find the largest product of 3 with numbers in order"
        = largest-product '("0123456789" 3)
        504)
    (test-success "5. can find the largest product of 3"
        = largest-product '("1027839564" 3)
        270)
    (test-success "6. can find the largest product of 5 with numbers in order"
        = largest-product '("0123456789" 5)
        15120)
    (test-success "7. can get the largest product of a big number"
        = largest-product '("73167176531330624919225119674426574742355349194934" 6)
        23520)
    (test-success "8. reports zero if the only digits are zero"
        = largest-product '("0000" 2)
        0)
    (test-success "9. reports zero if all spans include zero"
        = largest-product '("99099" 3)
        0)
    (test-error "10. rejects span longer than string length"
        largest-product '("123" 4))
    (test-success "11. reports 1 for empty string and empty product (0 span)"
        = largest-product '("" 0)
        1)
    (test-success "12. reports 1 for nonempty string and empty product (0 span)"
        = largest-product '("123" 0)
        1)
    (test-error "13. rejects empty string and nonzero span"
        largest-product '("" 1))
    (test-error "14. rejects invalid character in digits"
        largest-product '("1234a5" 2))
    (test-error "15. rejects negative span"
        largest-product '("12345" -1))
    ))

(run-with-cli "largest-series-product.scm" (list test-cases))
