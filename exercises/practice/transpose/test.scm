; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/transpose/canonical-data.json
; File last updated on 2026-10-21T18:44:59+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. empty string"
        equal? transpose '(())
        '())

    (test-success "2. two characters in a row"
        equal? transpose '(("A1"))
        '("A" "1"))

    (test-success "3. two characters in a column"
        equal? transpose '(("A" "1"))
        '("A1"))

    (test-success "4. simple"
        equal? transpose '(("ABC" "123"))
        '("A1" "B2" "C3"))

    (test-success "5. single line"
        equal? transpose '(("Single line."))
        '("S" "i" "n" "g" "l" "e" " " "l" "i" "n" "e" "."))

    (test-success "6. first line longer than second line"
        equal? transpose '(("The fourth line." "The fifth line."))
        '("TT" "hh" "ee" "  " "ff" "oi" "uf" "rt" "th" "h " " l" "li" "in" "ne" "e." "."))

    (test-success "7. second line longer than first line"
        equal? transpose '(("The first line." "The second line."))
        '("TT" "hh" "ee" "  " "fs" "ie" "rc" "so" "tn" " d" "l " "il" "ni" "en" ".e" " ."))

    (test-success "8. mixed line length"
        equal? transpose '(("The longest line." "A long line." "A longer line." "A line."))
        '("TAAA" "h   " "elll" " ooi" "lnnn" "ogge" "n e." "glr" "ei " "snl" "tei" " .n" "l e" "i ." "n" "e" "."))

    (test-success "9. square"
        equal? transpose '(("HEART" "EMBER" "ABUSE" "RESIN" "TREND"))
        '("HEART" "EMBER" "ABUSE" "RESIN" "TREND"))

    (test-success "10. rectangle"
        equal? transpose '(("FRACTURE" "OUTLINED" "BLOOMING" "SEPTETTE"))
        '("FOBS" "RULE" "ATOP" "CLOT" "TIME" "UNIT" "RENT" "EDGE"))

    (test-success "11. triangle"
        equal? transpose '(("T" "EE" "AAA" "SSSS" "EEEEE" "RRRRRR"))
        '("TEASER" " EASER" "  ASER" "   SER" "    ER" "     R"))

    (test-success "12. jagged triangle"
        equal? transpose '(("11" "2" "3333" "444" "555555" "66666"))
        '("123456" "1 3456" "  3456" "  3 56" "    56" "    5"))
    ))

(run-with-cli "transpose.scm" (list test-cases))
