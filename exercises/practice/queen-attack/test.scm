; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/queen-attack/canonical-data.json
; File last updated on 2026-10-21T21:30:48+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. cannot attack"
        eq? attacking? '((2 4) (6 6)) #f)

    (test-success "2. can attack on same row"
        eq? attacking? '((2 4) (2 6)) #t)

    (test-success "3. can attack on same column"
        eq? attacking? '((4 5) (2 5)) #t)

    (test-success "4. can attack on first diagonal"
        eq? attacking? '((2 2) (0 4)) #t)

    (test-success "5. can attack on second diagonal"
        eq? attacking? '((2 2) (3 1)) #t)

    (test-success "6. can attack on third diagonal"
        eq? attacking? '((2 2) (1 1)) #t)

    (test-success "7. can attack on fourth diagonal"
        eq? attacking? '((1 7) (0 6)) #t)

    (test-success "8. cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal"
        eq? attacking? '((4 1) (2 5)) #f)))

(run-with-cli "queen-attack.scm" (list test-cases))
