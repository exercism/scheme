; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/roman-numerals/canonical-data.json
; File last updated on 2026-10-20T19:41:15+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. 1 is I" equal? roman '(1) "I")

    (test-success "2. 2 is II" equal? roman '(2) "II")

    (test-success "3. 3 is III" equal? roman '(3) "III")

    (test-success "4. 4 is IV" equal? roman '(4) "IV")

    (test-success "5. 5 is V" equal? roman '(5) "V")

    (test-success "6. 6 is VI" equal? roman '(6) "VI")

    (test-success "7. 9 is IX" equal? roman '(9) "IX")

    (test-success "8. 16 is XVI" equal? roman '(16) "XVI")

    (test-success "9. 27 is XXVII" equal? roman '(27) "XXVII")

    (test-success "10. 48 is XLVIII" equal? roman '(48) "XLVIII")

    (test-success "11. 49 is XLIX" equal? roman '(49) "XLIX")

    (test-success "12. 59 is LIX" equal? roman '(59) "LIX")

    (test-success "13. 66 is LXVI" equal? roman '(66) "LXVI")

    (test-success "14. 93 is XCIII" equal? roman '(93) "XCIII")

    (test-success "15. 141 is CXLI" equal? roman '(141) "CXLI")

    (test-success "16. 163 is CLXIII" equal? roman '(163) "CLXIII")

    (test-success "17. 166 is CLXVI" equal? roman '(166) "CLXVI")

    (test-success "18. 402 is CDII" equal? roman '(402) "CDII")

    (test-success "19. 575 is DLXXV" equal? roman '(575) "DLXXV")

    (test-success "20. 666 is DCLXVI" equal? roman '(666) "DCLXVI")

    (test-success "21. 911 is CMXI" equal? roman '(911) "CMXI")

    (test-success "22. 1024 is MXXIV" equal? roman '(1024) "MXXIV")

    (test-success "23. 1666 is MDCLXVI" equal? roman '(1666) "MDCLXVI")

    (test-success "24. 3000 is MMM" equal? roman '(3000) "MMM")

    (test-success "25. 3001 is MMMI" equal? roman '(3001) "MMMI")

    (test-success "26. 3888 is MMMDCCCLXXXVIII" equal? roman '(3888) "MMMDCCCLXXXVIII")

    (test-success "27. 3999 is MMMCMXCIX" equal? roman '(3999) "MMMCMXCIX")
    ))

(run-with-cli "roman-numerals.scm" (list test-cases))



