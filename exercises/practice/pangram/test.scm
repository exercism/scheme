; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/pangram/canonical-data.json
; File last updated on 2026-10-19T18:52:03+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. empty sentence"
        eq? pangram? '("") #f)

    (test-success "2. perfect lower case"
        eq? pangram? '("abcdefghijklmnopqrstuvwxyz") #t)

    (test-success "3. only lower case"
        eq? pangram? '("the quick brown fox jumps over the lazy dog") #t)

    (test-success "4. missing the letter 'x'"
        eq? pangram? '("a quick movement of the enemy will jeopardize five gunboats") #f)

    (test-success "5. missing the letter 'h'"
        eq? pangram? '("five boxing wizards jump quickly at it") #f)

    (test-success "6. with underscores"
        eq? pangram? '("the_quick_brown_fox_jumps_over_the_lazy_dog") #t)

    (test-success "7. with numbers"
        eq? pangram? '("the 1 quick brown fox jumps over the 2 lazy dogs") #t)

    (test-success "8. missing letters replaced by numbers"
        eq? pangram? '("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog") #f)

    (test-success "9. mixed case and punctuation"
        eq? pangram? '("\"Five quacking Zephyrs jolt my wax bed.\"") #t)

    (test-success "10. a-m and A-M are 26 different characters but not a pangram"
        eq? pangram? '("abcdefghijklm ABCDEFGHIJKLM") #f)
    ))

(run-with-cli "pangram.scm" (list test-cases))
