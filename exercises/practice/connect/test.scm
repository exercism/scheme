; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/connect/canonical-data.json
; File last updated on 2026-10-27T07:13:35+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. an empty board has no winner"
        string=? winner
        '(#(". . . . ."
            " . . . . ."
            "  . . . . ."
            "   . . . . ."
            "    . . . . ."))
        "")

    (test-success "2. X can win on a 1x1 board"
        string=? winner
        '(#("X"))
        "X")

    (test-success "3. O can win on a 1x1 board"
        string=? winner
        '(#("O"))
        "O")

    (test-success "4. only edges does not make a winner"
        string=? winner
        '(#("O O O X"
            " X . . X"
            "  X . . X"
            "   X O O O"))
        "")

    (test-success "5. illegal diagonal does not make a winner"
        string=? winner
        '(#("X O . ."
            " O X X X"
            "  O X O ."
            "   . O X ."
            "    X X O O"))
        "")

    (test-success "6. nobody wins crossing adjacent angles"
        string=? winner
        '(#("X . . ."
            " . X O ."
            "  O . X O"
            "   . O . X"
            "    . . O ."))
        "")

    (test-success "7. X wins crossing from left to right"
        string=? winner
        '(#(". O . ."
            " O X X X"
            "  O X O ."
            "   X X O X"
            "    . O X ."))
        "X")

    (test-success "8. X wins with left-hand dead end fork"
        string=? winner
        '(#(". . X ."
            " X X . ."
            "  . X X X"
            "   O O O O"))
        "X")

    (test-success "9. X wins with right-hand dead end fork"
        string=? winner
        '(#(". . X X"
            " X X . ."
            "  . X X ."
            "   O O O O"))
        "X")

    (test-success "10. O wins crossing from top to bottom"
        string=? winner
        '(#(". O . ."
            " O X X X"
            "  O O O ."
            "   X X O X"
            "    . O X ."))
        "O")

    (test-success "11. X wins using a convoluted path"
        string=? winner
        '(#(". X X . ."
            " X . X . X"
            "  . X . X ."
            "   . X X . ."
            "    O O O O O"))
        "X")

    (test-success "12. X wins using a spiral path"
        string=? winner
        '(#("O X X X X X X X X"
            " O X O O O O O O O"
            "  O X O X X X X X O"
            "   O X O X O O O X O"
            "    O X O X X X O X O"
            "     O X O O O X O X O"
            "      O X X X X X O X O"
            "       O O O O O O O X O"
            "        X X X X X X X X O"))
        "X")))

(run-with-cli "connect.scm" (list test-cases))
