; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/phone-number/canonical-data.json
; File last updated on 2026-10-19T23:04:47+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. cleans the number"
        equal? clean '("(223) 456-7890") "2234567890")

    (test-success "2. cleans numbers with dots"
        equal? clean '("223.456.7890") "2234567890")

    (test-success "3. cleans numbers with multiple spaces"
        equal? clean '("223 456   7890   ") "2234567890")

    (test-error "4. invalid when 9 digits"
        clean '("123456789"))

    (test-error "5. invalid when 11 digits does not start with a 1"
        clean '("22234567890"))

    (test-success "6. valid when 11 digits and starting with 1"
        equal? clean '("12234567890") "2234567890")

    (test-success "7. valid when 11 digits and starting with 1 even with punctuation"
        equal? clean '("+1 (223) 456-7890") "2234567890")

    (test-error "8. invalid when more than 11 digits"
        clean '("321234567890"))

    (test-error "9. invalid with letters"
        clean '("523-abc-7890"))

    (test-error "10. invalid with punctuations"
        clean '("523-@:!-7890"))

    (test-error "11. invalid if area code starts with 0"
        clean '("(023) 456-7890"))

    (test-error "12. invalid if area code starts with 1"
        clean '("(123) 456-7890"))

    (test-error "13. invalid if exchange code starts with 0"
        clean '("(223) 056-7890"))

    (test-error "14. invalid if exchange code starts with 1"
        clean '("(223) 156-7890"))

    (test-error "15. invalid if area code starts with 0 on valid 11-digit number"
        clean '("1 (023) 456-7890"))

    (test-error "16. invalid if area code starts with 1 on valid 11-digit number"
        clean '("1 (123) 456-7890"))

    (test-error "17. invalid if exchange code starts with 0 on valid 11-digit number"
        clean '("1 (223) 056-7890"))

    (test-error "18. invalid if exchange code starts with 1 on valid 11-digit number"
        clean '("1 (223) 156-7890"))
    ))

(run-with-cli "phone-number.scm" (list test-cases))
