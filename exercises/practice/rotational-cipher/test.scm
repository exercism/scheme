; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/rotational-cipher/canonical-data.json
; File last updated on 2026-10-21T18:38:40+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. rotate a by 0, same output as input"
        equal? rotate '("a" 0)
        "a")

    (test-success "2. rotate a by 1"
        equal? rotate '("a" 1)
        "b")

    (test-success "3. rotate a by 26, same output as input"
        equal? rotate '("a" 26)
        "a")

    (test-success "4. rotate m by 13"
        equal? rotate '("m" 13)
        "z")

    (test-success "5. rotate n by 13 with wrap around alphabet"
        equal? rotate '("n" 13)
        "a")

    (test-success "6. rotate capital letters"
        equal? rotate '("OMG" 5)
        "TRL")

    (test-success "7. rotate spaces"
        equal? rotate '("O M G" 5)
        "T R L")

    (test-success "8. rotate numbers"
        equal? rotate '("Testing 1 2 3 testing" 4)
        "Xiwxmrk 1 2 3 xiwxmrk")

    (test-success "9. rotate punctuation"
        equal? rotate '("Let's eat, Grandma!" 21)
        "Gzo'n zvo, Bmviyhv!")

    (test-success "10. rotate all letters"
        equal? rotate '("The quick brown fox jumps over the lazy dog." 13)
        "Gur dhvpx oebja sbk whzcf bire gur ynml qbt.")
    ))

(run-with-cli "rotational-cipher.scm" (list test-cases))
