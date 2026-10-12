; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/luhn/canonical-data.json
; File last updated on 2026-10-12T12:09:56+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. single digit strings can not be valid"
        eq? valid? '("1") #f)

    (test-success "2. a single zero is invalid"
        eq? valid? '("0") #f)

    (test-success "3. a simple valid SIN that remains valid if reversed"
        eq? valid? '("059") #t)

    (test-success "4. a simple valid SIN that becomes invalid if reversed"
        eq? valid? '("59") #t)

    (test-success "5. a valid Canadian SIN"
        eq? valid? '("055 444 285") #t)

    (test-success "6. invalid Canadian SIN"
        eq? valid? '("055 444 286") #f)

    (test-success "7. invalid credit card"
        eq? valid? '("8273 1232 7352 0569") #f)

    (test-success "8. invalid long number with an even remainder"
        eq? valid? '("1 2345 6789 1234 5678 9012") #f)

    (test-success "9. invalid long number with a remainder divisible by 5"
        eq? valid? '("1 2345 6789 1234 5678 9013") #f)

    (test-success "10. valid number with an even number of digits"
        eq? valid? '("095 245 88") #t)

    (test-success "11. valid number with an odd number of spaces"
        eq? valid? '("234 567 891 234") #t)

    (test-success "12. valid strings with a non-digit added at the end become invalid"
        eq? valid? '("059a") #f)

    (test-success "13. valid strings with punctuation included become invalid"
        eq? valid? '("055-444-285") #f)

    (test-success "14. valid strings with symbols included become invalid"
        eq? valid? '("055# 444$ 285") #f)

    (test-success "15. single zero with space is invalid"
        eq? valid? '(" 0") #f)

    (test-success "16. more than a single zero is valid"
        eq? valid? '("0000 0") #t)

    (test-success "17. input digit 9 is correctly converted to output digit 9"
        eq? valid? '("091") #t)

    (test-success "18. very long input is valid"
        eq? valid? '("9999999999 9999999999 9999999999 9999999999") #t)

    (test-success "19. valid luhn with an odd number of digits and non zero first digit"
        eq? valid? '("109") #t)

    (test-success "20. using ascii value for non-doubled non-digit isn't allowed"
        eq? valid? '("055b 444 285") #f)

    (test-success "21. using ascii value for doubled non-digit isn't allowed"
        eq? valid? '(":9") #f)

    (test-success "22. non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed"
        eq? valid? '("59%59") #f)

    ))

(run-with-cli "luhn.scm" (list test-cases))
