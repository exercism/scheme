; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/isbn-verifier/canonical-data.json
; File last updated on 2026-10-12T04:36:45+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. valid isbn"
        eq? valid? '("3-598-21508-8") #t)

    (test-success "2. invalid isbn check digit"
        eq? valid? '("3-598-21508-9") #f)

    (test-success "3. valid isbn with a check digit of 10"
        eq? valid? '("3-598-21507-X") #t)

    (test-success "4. check digit is a character other than X"
        eq? valid? '("3-598-21507-A") #f)

    (test-success "5. invalid check digit in isbn is not treated as zero"
        eq? valid? '("4-598-21507-B") #f)

    (test-success "6. invalid character in isbn is not treated as zero"
        eq? valid? '("3-598-P1581-X") #f)

    (test-success "7. X is only valid as a check digit"
        eq? valid? '("3-598-2X507-9") #f)

    (test-success "8. only one check digit is allowed"
        eq? valid? '("3-598-21508-96") #f)

    (test-success "9. X is not substituted by the value 10"
        eq? valid? '("3-598-2X507-5") #f)

    (test-success "10. valid isbn without separating dashes"
        eq? valid? '("3598215088") #t)

    (test-success "11. isbn without separating dashes and X as check digit"
        eq? valid? '("359821507X") #t)

    (test-success "12. isbn without check digit and dashes"
        eq? valid? '("359821507") #f)

    (test-success "13. too long isbn and no dashes"
        eq? valid? '("3598215078X") #f)

    (test-success "14. too short isbn"
        eq? valid? '("00") #f)

    (test-success "15. isbn without check digit"
        eq? valid? '("3-598-21507") #f)

    (test-success "16. check digit of X should not be used for 0"
        eq? valid? '("3-598-21515-X") #f)

    (test-success "17. empty isbn"
        eq? valid? '("") #f)

    (test-success "18. input is 9 characters"
        eq? valid? '("134456729") #f)

    (test-success "19. invalid characters are not ignored after checking length"
        eq? valid? '("3132P34035") #f)

    (test-success "20. invalid characters are not ignored before checking length"
        eq? valid? '("3598P215088") #f)

    (test-success "21. input is too long but contains a valid isbn"
        eq? valid? '("98245726788") #f)

    ))

(run-with-cli "isbn-verifier.scm" (list test-cases))
