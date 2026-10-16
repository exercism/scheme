; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/rectangles/canonical-data.json
; File last updated on 2026-10-19T19:28:34+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. no rows"
        = rectangles
        '(())
        0)

    (test-success "2. no columns"
        = rectangles
        '((""))
        0)

    (test-success "3. no rectangles"
        = rectangles
        '((" "))
        0)

    (test-success "4. one rectangle"
        = rectangles
        '(("+-+"
           "| |"
           "+-+"))
        1)

    (test-success "5. two rectangles without shared parts"
        = rectangles
        '(("  +-+"
           "  | |"
           "+-+-+"
           "| |  "
           "+-+  "))
        2)

    (test-success "6. five rectangles with shared parts"
        = rectangles
        '(("  +-+"
           "  | |"
           "+-+-+"
           "| | |"
           "+-+-+"))
        5)

    (test-success "7. rectangle of height 1 is counted"
        = rectangles
        '(("+--+"
           "+--+"))
        1)

    (test-success "8. rectangle of width 1 is counted"
        = rectangles
        '(("++"
           "||"
           "++"))
        1)

    (test-success "9. 1x1 square is counted"
        = rectangles
        '(("++"
           "++"))
        1)

    (test-success "10. only complete rectangles are counted"
        = rectangles
        '(("  +-+"
           "    |"
           "+-+-+"
           "| | -"
           "+-+-+"))
        1)

    (test-success "11. rectangles can be of different sizes"
        = rectangles
        '(("+------+----+"
           "|      |    |"
           "+---+--+    |"
           "|   |       |"
           "+---+-------+"))
        3)

    (test-success "12. corner is required for a rectangle to be complete"
        = rectangles
        '(("+------+----+"
           "|      |    |"
           "+------+    |"
           "|   |       |"
           "+---+-------+"))
        2)

    (test-success "13. large input with many rectangles"
        = rectangles
        '(("+---+--+----+"
           "|   +--+----+"
           "+---+--+    |"
           "|   +--+----+"
           "+---+--+--+-+"
           "+---+--+--+-+"
           "+------+  | |"
           "          +-+"))
        60)

    (test-success "14. rectangles must have four sides"
        = rectangles
        '(("+-+ +-+"
           "| | | |"
           "+-+-+-+"
           "  | |  "
           "+-+-+-+"
           "| | | |"
           "+-+ +-+"))
        5)))

(run-with-cli "rectangles.scm" (list test-cases))
