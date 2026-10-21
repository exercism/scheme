; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/strain/canonical-data.json
; File last updated on 2026-10-21T19:22:20+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. keep on empty list returns empty list"
        equal? keep `(,(lambda (x) #t) ())
        '())

    (test-success "2. keeps everything"
        equal? keep `(,(lambda (x) #t) (1 3 5))
        '(1 3 5))

    (test-success "3. keeps nothing"
        equal? keep `(,(lambda (x) #f) (1 3 5))
        '())

    (test-success "4. keeps first and last"
        equal? keep `(,odd? (1 2 3))
        '(1 3))

    (test-success "5. keeps neither first nor last"
        equal? keep `(,even? (1 2 3))
        '(2))

    (test-success "6. keeps strings"
        equal? keep `(,(lambda (x) (char=? (string-ref x 0) #\z)) ("apple" "zebra" "banana" "zombies" "cherimoya" "zealot"))
        '("zebra" "zombies" "zealot"))

    (test-success "7. keeps lists"
        equal? keep `(,(lambda (x) (memv 5 x)) ((1 2 3) (5 5 5) (5 1 2) (2 1 2) (1 5 2) (2 2 1) (1 2 5)))
        '((5 5 5) (5 1 2) (1 5 2) (1 2 5)))

    (test-success "8. discard on empty list returns empty list"
        equal? discard `(,(lambda (x) #t) ())
        '())

    (test-success "9. discards everything"
        equal? discard `(,(lambda (x) #t) (1 3 5))
        '())

    (test-success "10. discards nothing"
        equal? discard `(,(lambda (x) #f) (1 3 5))
        '(1 3 5))

    (test-success "11. discards first and last"
        equal? discard `(,odd? (1 2 3))
        '(2))

    (test-success "12. discards neither first nor last"
        equal? discard `(,even? (1 2 3))
        '(1 3))

    (test-success "13. discards strings"
        equal? discard `(,(lambda (x) (char=? (string-ref x 0) #\z)) ("apple" "zebra" "banana" "zombies" "cherimoya" "zealot"))
        '("apple" "banana" "cherimoya"))

    (test-success "14. discards lists"
        equal? discard `(,(lambda (x) (memv 5 x)) ((1 2 3) (5 5 5) (5 1 2) (2 1 2) (1 5 2) (2 2 1) (1 2 5)))
        '((1 2 3) (2 1 2) (2 2 1)))
    ))

(run-with-cli "strain.scm" (list test-cases))
