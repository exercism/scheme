; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/state-of-tic-tac-toe/canonical-data.json
; File last updated on 2026-10-24T05:37:51+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. Finished game where X won via left column victory"
        eq? gamestate
        '(("XOO"
           "X  "
           "X  "))
        'win)

    (test-success "2. Finished game where X won via middle column victory"
        eq? gamestate
        '(("OXO"
           " X "
           " X "))
        'win)

    (test-success "3. Finished game where X won via right column victory"
        eq? gamestate
        '(("OOX"
           "  X"
           "  X"))
        'win)

    (test-success "4. Finished game where O won via left column victory"
        eq? gamestate
        '(("OXX"
           "OX "
           "O  "))
        'win)

    (test-success "5. Finished game where O won via middle column victory"
        eq? gamestate
        '(("XOX"
           " OX"
           " O "))
        'win)

    (test-success "6. Finished game where O won via right column victory"
        eq? gamestate
        '(("XXO"
           " XO"
           "  O"))
        'win)

    (test-success "7. Finished game where X won via top row victory"
        eq? gamestate
        '(("XXX"
           "XOO"
           "O  "))
        'win)

    (test-success "8. Finished game where X won via middle row victory"
        eq? gamestate
        '(("O  "
           "XXX"
           " O "))
        'win)

    (test-success "9. Finished game where X won via bottom row victory"
        eq? gamestate
        '((" OO"
           "O X"
           "XXX"))
        'win)

    (test-success "10. Finished game where O won via top row victory"
        eq? gamestate
        '(("OOO"
           "XXO"
           "XX "))
        'win)

    (test-success "11. Finished game where O won via middle row victory"
        eq? gamestate
        '(("XX "
           "OOO"
           "X  "))
        'win)

    (test-success "12. Finished game where O won via bottom row victory"
        eq? gamestate
        '(("XOX"
           " XX"
           "OOO"))
        'win)

    (test-success "13. Finished game where X won via falling diagonal victory"
        eq? gamestate
        '(("XOO"
           " X "
           "  X"))
        'win)

    (test-success "14. Finished game where X won via rising diagonal victory"
        eq? gamestate
        '(("O X"
           "OX "
           "X  "))
        'win)

    (test-success "15. Finished game where O won via falling diagonal victory"
        eq? gamestate
        '(("OXX"
           "OOX"
           "X O"))
        'win)

    (test-success "16. Finished game where O won via rising diagonal victory"
        eq? gamestate
        '(("  O"
           " OX"
           "OXX"))
        'win)

    (test-success "17. Finished game where X won via a row and a column victory"
        eq? gamestate
        '(("XXX"
           "XOO"
           "XOO"))
        'win)

    (test-success "18. Finished game where X won via two diagonal victories"
        eq? gamestate
        '(("XOX"
           "OXO"
           "XOX"))
        'win)

    (test-success "19. Draw"
        eq? gamestate
        '(("XOX"
           "XXO"
           "OXO"))
        'draw)

    (test-success "20. Another draw"
        eq? gamestate
        '(("XXO"
           "OXX"
           "XOO"))
        'draw)

    (test-success "21. Ongoing game: one move in"
        eq? gamestate
        '(("   "
           "X  "
           "   "))
        'ongoing)

    (test-success "22. Ongoing game: two moves in"
        eq? gamestate
        '(("O  "
           " X "
           "   "))
        'ongoing)

    (test-success "23. Ongoing game: five moves in"
        eq? gamestate
        '(("X  "
           " XO"
           "OX "))
        'ongoing)

    (test-error "24. Invalid board: X went twice"
        gamestate
        '(("XX "
           "   "
           "   ")))

    (test-error "25. Invalid board: O started"
        gamestate
        '(("OOX"
           "   "
           "   ")))

    (test-error "26. Invalid board: X won and O kept playing"
        gamestate
        '(("XXX"
           "OOO"
           "   ")))

    (test-error "27. Invalid board: players kept playing after a win"
        gamestate
        '(("XXX"
           "OOO"
           "XOX")))

    (test-error "28. Invalid board: O kept playing after X wins"
        gamestate
        '(("OO "
           "XXX"
           " O ")))

    (test-error "29. Invalid board: X kept playing after O wins"
        gamestate
        '(("XX "
           "OOO"
           " XX")))))

(run-with-cli "state-of-tic-tac-toe.scm" (list test-cases))
