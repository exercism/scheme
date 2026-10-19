; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/crypto-square/canonical-data.json
; File last updated on 2026-10-19T09:07:11+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. empty plaintext results in an empty ciphertext"
        string=? encipher '("")
        "")

    (test-success "2. normalization results in empty plaintext"
        string=? encipher '("... --- ...")
        "")

    (test-success "3. Lowercase"
        string=? encipher '("A")
        "a")

    (test-success "4. Remove spaces"
        string=? encipher '("  b ")
        "b")

    (test-success "5. Remove punctuation"
        string=? encipher '("@1,%!")
        "1")

    (test-success "6. 9 character plaintext results in 3 chunks of 3 characters"
        string=? encipher '("This is fun!")
        "tsf hiu isn")

    (test-success "7. 8 character plaintext results in 3 chunks, the last one with a trailing space"
        string=? encipher '("Chill out.")
        "clu hlt io ")

    (test-success "8. 54 character plaintext results in 8 chunks, the last two with trailing spaces"
        string=? encipher '("If man was meant to stay on the ground, god would have given us roots.")
        "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau ")
    ))

(run-with-cli "crypto-square.scm" (list test-cases))
