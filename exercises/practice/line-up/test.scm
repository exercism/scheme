; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/line-up/canonical-data.json
; File last updated on 2026-10-13T08:11:10+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. format smallest non-exceptional ordinal numeral 4"
        string=? format-message '("Gianna" 4)
        "Gianna, you are the 4th customer we serve today. Thank you!")
    (test-success "2. format greatest single digit non-exceptional ordinal numeral 9"
        string=? format-message '("Maarten" 9)
        "Maarten, you are the 9th customer we serve today. Thank you!")
    (test-success "3. format non-exceptional ordinal numeral 5"
        string=? format-message '("Petronila" 5)
        "Petronila, you are the 5th customer we serve today. Thank you!")
    (test-success "4. format non-exceptional ordinal numeral 6"
        string=? format-message '("Attakullakulla" 6)
        "Attakullakulla, you are the 6th customer we serve today. Thank you!")
    (test-success "5. format non-exceptional ordinal numeral 7"
        string=? format-message '("Kate" 7)
        "Kate, you are the 7th customer we serve today. Thank you!")
    (test-success "6. format non-exceptional ordinal numeral 8"
        string=? format-message '("Maximiliano" 8)
        "Maximiliano, you are the 8th customer we serve today. Thank you!")
    (test-success "7. format exceptional ordinal numeral 1"
        string=? format-message '("Mary" 1)
        "Mary, you are the 1st customer we serve today. Thank you!")
    (test-success "8. format exceptional ordinal numeral 2"
        string=? format-message '("Haruto" 2)
        "Haruto, you are the 2nd customer we serve today. Thank you!")
    (test-success "9. format exceptional ordinal numeral 3"
        string=? format-message '("Henriette" 3)
        "Henriette, you are the 3rd customer we serve today. Thank you!")
    (test-success "10. format smallest two digit non-exceptional ordinal numeral 10"
        string=? format-message '("Alvarez" 10)
        "Alvarez, you are the 10th customer we serve today. Thank you!")
    (test-success "11. format non-exceptional ordinal numeral 11"
        string=? format-message '("Jacqueline" 11)
        "Jacqueline, you are the 11th customer we serve today. Thank you!")
    (test-success "12. format non-exceptional ordinal numeral 12"
        string=? format-message '("Juan" 12)
        "Juan, you are the 12th customer we serve today. Thank you!")
    (test-success "13. format non-exceptional ordinal numeral 13"
        string=? format-message '("Patricia" 13)
        "Patricia, you are the 13th customer we serve today. Thank you!")
    (test-success "14. format exceptional ordinal numeral 21"
        string=? format-message '("Washi" 21)
        "Washi, you are the 21st customer we serve today. Thank you!")
    (test-success "15. format exceptional ordinal numeral 22 ending in nd even though it is a multiple of 11"
        string=? format-message '("Ingrid" 22)
        "Ingrid, you are the 22nd customer we serve today. Thank you!")
    (test-success "16. format exceptional ordinal numeral 33 ending in rd even though it is a multiple of 11"
        string=? format-message '("Mario" 33)
        "Mario, you are the 33rd customer we serve today. Thank you!")
    (test-success "17. format exceptional ordinal numeral 52 ending in nd even though it is a multiple of 13"
        string=? format-message '("Quentin" 52)
        "Quentin, you are the 52nd customer we serve today. Thank you!")
    (test-success "18. format exceptional ordinal numeral 62"
        string=? format-message '("Nayra" 62)
        "Nayra, you are the 62nd customer we serve today. Thank you!")
    (test-success "19. format non-exceptional ordinal numeral 72 ending in nd even though it is a multiple of 12"
        string=? format-message '("Ugo" 72)
        "Ugo, you are the 72nd customer we serve today. Thank you!")
    (test-success "20. format exceptional ordinal numeral 91 ending in st even though it is a multiple of 13"
        string=? format-message '("Boris" 91)
        "Boris, you are the 91st customer we serve today. Thank you!")
    (test-success "21. format exceptional ordinal numeral 100"
        string=? format-message '("John" 100)
        "John, you are the 100th customer we serve today. Thank you!")
    (test-success "22. format exceptional ordinal numeral 101"
        string=? format-message '("Zeinab" 101)
        "Zeinab, you are the 101st customer we serve today. Thank you!")
    (test-success "23. format non-exceptional ordinal numeral 112"
        string=? format-message '("Knud" 112)
        "Knud, you are the 112th customer we serve today. Thank you!")
    (test-success "24. format exceptional ordinal numeral 123"
        string=? format-message '("Yma" 123)
        "Yma, you are the 123rd customer we serve today. Thank you!")
    (test-success "25. format large number 972 ending in nd even though it is a multiple of 12"
        string=? format-message '("Elias" 972)
        "Elias, you are the 972nd customer we serve today. Thank you!")
    ))

(run-with-cli "line-up.scm" (list test-cases))
