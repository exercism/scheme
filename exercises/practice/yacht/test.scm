; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/yacht/canonical-data.json
; File last updated on 2026-10-14T08:41:23+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. Yacht"
        = score '(yacht #(5 5 5 5 5))
        50)
    (test-success "2. Not Yacht"
        = score '(yacht #(1 3 3 2 5))
        0)
    (test-success "3. Ones"
        = score '(ones #(1 1 1 3 5))
        3)
    (test-success "4. Ones, out of order"
        = score '(ones #(3 1 1 5 1))
        3)
    (test-success "5. No ones"
        = score '(ones #(4 3 6 5 5))
        0)
    (test-success "6. Twos"
        = score '(twos #(2 3 4 5 6))
        2)
    (test-success "7. Fours"
        = score '(fours #(1 4 1 4 1))
        8)
    (test-success "8. Yacht counted as threes"
        = score '(threes #(3 3 3 3 3))
        15)
    (test-success "9. Yacht of 3s counted as fives"
        = score '(fives #(3 3 3 3 3))
        0)
    (test-success "10. Fives"
        = score '(fives #(1 5 3 5 3))
        10)
    (test-success "11. Sixes"
        = score '(sixes #(2 3 4 5 6))
        6)
    (test-success "12. Full house two small, three big"
        = score '(full-house #(2 2 4 4 4))
        16)
    (test-success "13. Full house three small, two big"
        = score '(full-house #(5 3 3 5 3))
        19)
    (test-success "14. Two pair is not a full house"
        = score '(full-house #(2 2 4 4 5))
        0)
    (test-success "15. Four of a kind is not a full house"
        = score '(full-house #(1 4 4 4 4))
        0)
    (test-success "16. Yacht is not a full house"
        = score '(full-house #(2 2 2 2 2))
        0)
    (test-success "17. Four of a Kind"
        = score '(four-of-a-kind #(6 6 4 6 6))
        24)
    (test-success "18. Yacht can be scored as Four of a Kind"
        = score '(four-of-a-kind #(3 3 3 3 3))
        12)
    (test-success "19. Full house is not Four of a Kind"
        = score '(four-of-a-kind #(3 3 3 5 5))
        0)
    (test-success "20. Little Straight"
        = score '(little-straight #(3 5 4 1 2))
        30)
    (test-success "21. Little Straight as Big Straight"
        = score '(big-straight #(1 2 3 4 5))
        0)
    (test-success "22. Four in order but not a little straight"
        = score '(little-straight #(1 1 2 3 4))
        0)
    (test-success "23. No pairs but not a little straight"
        = score '(little-straight #(1 2 3 4 6))
        0)
    (test-success "24. Minimum is 1, maximum is 5, but not a little straight"
        = score '(little-straight #(1 1 3 4 5))
        0)
    (test-success "25. Big Straight"
        = score '(big-straight #(4 6 2 5 3))
        30)
    (test-success "26. Big Straight as little straight"
        = score '(little-straight #(6 5 4 3 2))
        0)
    (test-success "27. No pairs but not a big straight"
        = score '(big-straight #(6 5 4 3 1))
        0)
    (test-success "28. Choice"
        = score '(choice #(3 3 5 6 6))
        23)
    (test-success "29. Yacht as choice"
        = score '(choice #(2 2 2 2 2))
        10)
    ))

(run-with-cli "yacht.scm" (list test-cases))
