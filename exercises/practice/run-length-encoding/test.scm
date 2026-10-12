; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/run-length-encoding/canonical-data.json
; File last updated on 2026-10-13T01:47:51+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. empty string"
        string=? encode '("") "")
    (test-success "2. single characters only are encoded without count"
        string=? encode '("XYZ") "XYZ")
    (test-success "3. string with no single characters"
        string=? encode '("AABBBCCCC") "2A3B4C")
    (test-success "4. single characters mixed with repeated characters"
        string=? encode '("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB") "12WB12W3B24WB")
    (test-success "5. multiple whitespace mixed in string"
        string=? encode '("  hsqq qww  ") "2 hs2q q2w2 ")
    (test-success "6. lowercase characters"
        string=? encode '("aabbbcccc") "2a3b4c")
    (test-success "7. empty string"
        string=? decode '("") "")
    (test-success "8. single characters only"
        string=? decode '("XYZ") "XYZ")
    (test-success "9. string with no single characters"
        string=? decode '("2A3B4C") "AABBBCCCC")
    (test-success "10. single characters with repeated characters"
        string=? decode '("12WB12W3B24WB") "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")
    (test-success "11. multiple whitespace mixed in string"
        string=? decode '("2 hs2q q2w2 ") "  hsqq qww  ")
    (test-success "12. lowercase string"
        string=? decode '("2a3b4c") "aabbbcccc")
    (test-success "13. encode followed by decode gives original string"
        string=? (lambda (string) (decode (encode string))) '("zzz ZZ  zZ") "zzz ZZ  zZ")
    ))

(run-with-cli "run-length-encoding.scm" (list test-cases))
