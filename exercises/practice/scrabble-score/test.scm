; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/scrabble-score/canonical-data.json
; File last updated on 2026-10-21T17:12:30+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. lowercase letter" = score '("a") 1)

    (test-success "2. uppercase letter" = score '("A") 1)

    (test-success "3. valuable letter" = score '("f") 4)

    (test-success "4. short word" = score '("at") 2)

    (test-success "5. short, valuable word" = score '("zoo") 12)

    (test-success "6. medium word" = score '("street") 6)

    (test-success "7. medium, valuable word" = score '("quirky") 22)

    (test-success "8. long, mixed-case word" = score '("OxyphenButazone") 41)

    (test-success "9. english-like word" = score '("pinata") 8)

    (test-success "10. empty input" = score '("") 0)

    (test-success "11. entire alphabet available" = score '("abcdefghijklmnopqrstuvwxyz") 87)
    ))

(run-with-cli "scrabble-score.scm" (list test-cases))
