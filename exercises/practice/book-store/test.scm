; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/book-store/canonical-data.json
; File last updated on 2026-10-14T23:28:46+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. Only a single book"
        = total '((1))
        800)
    (test-success "2. Two of the same book"
        = total '((2 2))
        1600)
    (test-success "3. Empty basket"
        = total '(())
        0)
    (test-success "4. Two different books"
        = total '((1 2))
        1520)
    (test-success "5. Three different books"
        = total '((1 2 3))
        2160)
    (test-success "6. Four different books"
        = total '((1 2 3 4))
        2560)
    (test-success "7. Five different books"
        = total '((1 2 3 4 5))
        3000)
    (test-success "8. Two groups of four is cheaper than group of five plus group of three"
        = total '((1 1 2 2 3 3 4 5))
        5120)
    (test-success "9. Two groups of four is cheaper than groups of five and three"
        = total '((1 1 2 3 4 4 5 5))
        5120)
    (test-success "10. Group of four plus group of two is cheaper than two groups of three"
        = total '((1 1 2 2 3 4))
        4080)
    (test-success "11. Two each of first four books and one copy each of rest"
        = total '((1 1 2 2 3 3 4 4 5))
        5560)
    (test-success "12. Two copies of each book"
        = total '((1 1 2 2 3 3 4 4 5 5))
        6000)
    (test-success "13. Three copies of first book and two each of remaining"
        = total '((1 1 2 2 3 3 4 4 5 5 1))
        6800)
    (test-success "14. Three each of first two books and two each of remaining books"
        = total '((1 1 2 2 3 3 4 4 5 5 1 2))
        7520)
    (test-success "15. Four groups of four are cheaper than two groups each of five and three"
        = total '((1 1 2 2 3 3 4 5 1 1 2 2 3 3 4 5))
        10240)
    (test-success "16. Check that groups of four are created properly even when there are more groups of three than groups of five"
        = total '((1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 3 4 4 5 5))
        14560)
    (test-success "17. One group of one and four is cheaper than one group of two and three"
        = total '((1 1 2 3 4))
        3360)
    (test-success "18. One group of one and two plus three groups of four is cheaper than one group of each size"
        = total '((1 2 2 3 3 3 4 4 4 4 5 5 5 5 5))
        10000)
    ))

(run-with-cli "book-store.scm" (list test-cases))
