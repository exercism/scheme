; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/affine-cipher/canonical-data.json
; File last updated on 2026-10-21T18:40:20+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. encode yes"
        equal? encode '((5 . 7) "yes")
        "xbt")

    (test-success "2. encode no"
        equal? encode '((15 . 18) "no")
        "fu")

    (test-success "3. encode OMG"
        equal? encode '((21 . 3) "OMG")
        "lvz")

    (test-success "4. encode O M G"
        equal? encode '((25 . 47) "O M G")
        "hjp")

    (test-success "5. encode mindblowingly"
        equal? encode '((11 . 15) "mindblowingly")
        "rzcwa gnxzc dgt")

    (test-success "6. encode numbers"
        equal? encode '((3 . 4) "Testing,1 2 3, testing.")
        "jqgjc rw123 jqgjc rw")

    (test-success "7. encode deep thought"
        equal? encode '((5 . 17) "Truth is fiction.")
        "iynia fdqfb ifje")

    (test-success "8. encode all the letters"
        equal? encode '((17 . 33) "The quick brown fox jumps over the lazy dog.")
        "swxtj npvyk lruol iejdc blaxk swxmh qzglf")

    (test-error "9. encode with a not coprime to m"
        encode '((6 . 17) "This is a test."))

    (test-success "10. decode exercism"
        equal? decode '((3 . 7) "tytgn fjr")
        "exercism")

    (test-success "11. decode a sentence"
        equal? decode '((19 . 16) "qdwju nqcro muwhn odqun oppmd aunwd o")
        "anobstacleisoftenasteppingstone")

    (test-success "12. decode numbers"
        equal? decode '((25 . 7) "odpoz ub123 odpoz ub")
        "testing123testing")

    (test-success "13. decode all the letters"
        equal? decode '((17 . 33) "swxtj npvyk lruol iejdc blaxk swxmh qzglf")
        "thequickbrownfoxjumpsoverthelazydog")

    (test-success "14. decode with no spaces in input"
        equal? decode '((17 . 33) "swxtjnpvyklruoliejdcblaxkswxmhqzglf")
        "thequickbrownfoxjumpsoverthelazydog")

    (test-success "15. decode with too many spaces"
        equal? decode '((15 . 16) "vszzm    cly   yd cg    qdp")
        "jollygreengiant")

    (test-error "16. decode with a not coprime to m"
        decode '((13 . 5) "Test"))
    ))

(run-with-cli "affine-cipher.scm" (list test-cases))
