; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/hamming/canonical-data.json
; File last updated on 2026-10-21T17:04:34+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. empty strands" = hamming-distance '("" "") 0)

    (test-success "2. single letter identical strands" = hamming-distance '("A" "A") 0)

    (test-success "3. single letter different strands" = hamming-distance '("G" "T") 1)

    (test-success "4. long identical strands" = hamming-distance '("GGACTGAAATCTG" "GGACTGAAATCTG") 0)

    (test-success "5. long different strands" = hamming-distance '("GGACGGATTCTG" "AGGACGGATTCT") 9)

    (test-error "6. disallow first strand longer" hamming-distance '("AATG" "AAA"))

    (test-error "7. disallow second strand longer" hamming-distance '("ATA" "AGTG"))

    (test-error "8. disallow empty first strand" hamming-distance '("" "G"))

    (test-error "9. disallow empty second strand" hamming-distance '("G" ""))
    ))

(run-with-cli "hamming.scm" (list test-cases))
