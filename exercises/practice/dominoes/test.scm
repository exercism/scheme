; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/dominoes/canonical-data.json
; File last updated on 2026-10-27T21:58:50+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. empty input = empty output"
        eq? can-chain? '()
        #t)

    (test-success "2. singleton input = singleton output"
        eq? can-chain? '((1 . 1))
        #t)

    (test-success "3. singleton that can't be chained"
        eq? can-chain? '((1 . 2))
        #f)

    (test-success "4. three elements"
        eq? can-chain? '((1 . 2) (3 . 1) (2 . 3))
        #t)

    (test-success "5. can reverse dominoes"
        eq? can-chain? '((1 . 2) (1 . 3) (2 . 3))
        #t)

    (test-success "6. can't be chained"
        eq? can-chain? '((1 . 2) (4 . 1) (2 . 3))
        #f)

    (test-success "7. disconnected - simple"
        eq? can-chain? '((1 . 1) (2 . 2))
        #f)

    (test-success "8. disconnected - double loop"
        eq? can-chain? '((1 . 2) (2 . 1) (3 . 4) (4 . 3))
        #f)

    (test-success "9. disconnected - single isolated"
        eq? can-chain? '((1 . 2) (2 . 3) (3 . 1) (4 . 4))
        #f)

    (test-success "10. need backtrack"
        eq? can-chain? '((1 . 2) (2 . 3) (3 . 1) (2 . 4) (2 . 4))
        #t)

    (test-success "11. separate loops"
        eq? can-chain? '((1 . 2) (2 . 3) (3 . 1) (1 . 1) (2 . 2) (3 . 3))
        #t)

    (test-success "12. nine elements"
        eq? can-chain? '((1 . 2) (5 . 3) (3 . 1) (1 . 2) (2 . 4) (1 . 6) (2 . 3) (3 . 4) (5 . 6))
        #t)

    (test-success "13. separate three-domino loops"
        eq? can-chain? '((1 . 2) (2 . 3) (3 . 1) (4 . 5) (5 . 6) (6 . 4))
        #f)))

(run-with-cli "dominoes.scm" (list test-cases))
