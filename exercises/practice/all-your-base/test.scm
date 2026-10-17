; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/all-your-base/canonical-data.json
; File last updated on 2026-10-15T23:52:50+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. single bit one to decimal"
        equal? rebase '(2 (1) 10)
        `(1))

    (test-success "2. binary to single decimal"
        equal? rebase '(2 (1 0 1) 10)
        `(5))

    (test-success "3. single decimal to binary"
        equal? rebase '(10 (5) 2)
        `(1 0 1))

    (test-success "4. binary to multiple decimal"
        equal? rebase '(2 (1 0 1 0 1 0) 10)
        `(4 2))

    (test-success "5. decimal to binary"
        equal? rebase '(10 (4 2) 2)
        `(1 0 1 0 1 0))

    (test-success "6. trinary to hexadecimal"
        equal? rebase '(3 (1 1 2 0) 16)
        `(2 10))

    (test-success "7. hexadecimal to trinary"
        equal? rebase '(16 (2 10) 3)
        `(1 1 2 0))

    (test-success "8. 15-bit integer"
        equal? rebase '(97 (3 46 60) 73)
        `(6 10 45))

    (test-success "9. empty list"
        equal? rebase '(2 () 10)
        `(0))

    (test-success "10. single zero"
        equal? rebase '(10 (0) 2)
        `(0))

    (test-success "11. multiple zeros"
        equal? rebase '(10 (0 0 0) 2)
        `(0))

    (test-success "12. leading zeros"
        equal? rebase '(7 (0 6 0) 10)
        `(4 2))

    (test-error "13. input base is one"
        rebase '(1 (0) 10))

    (test-error "14. input base is zero"
        rebase '(0 () 10))

    (test-error "15. input base is negative"
        rebase '(-2 (1) 10))

    (test-error "16. negative digit"
        rebase '(2 (1 -1 1 0 1 0) 10))

    (test-error "17. invalid positive digit"
        rebase '(2 (1 2 1 0 1 0) 10))

    (test-error "18. output base is one"
        rebase '(2 (1 0 1 0 1 0) 1))

    (test-error "19. output base is zero"
        rebase '(10 (7) 0))

    (test-error "20. output base is negative"
        rebase '(2 (1) -7))

    (test-error "21. both bases are negative"
        rebase '(-2 (1) -7))
    ))

(run-with-cli "all-your-base.scm" (list test-cases))
