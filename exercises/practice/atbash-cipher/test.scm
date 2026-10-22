; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/atbash-cipher/canonical-data.json
; File last updated on 2026-10-21T18:37:34+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. encode yes"
        equal? encode '("yes")
        "bvh")

    (test-success "2. encode no"
        equal? encode '("no")
        "ml")

    (test-success "3. encode OMG"
        equal? encode '("OMG")
        "lnt")

    (test-success "4. encode spaces"
        equal? encode '("O M G")
        "lnt")

    (test-success "5. encode mindblowingly"
        equal? encode '("mindblowingly")
        "nrmwy oldrm tob")

    (test-success "6. encode numbers"
        equal? encode '("Testing,1 2 3, testing.")
        "gvhgr mt123 gvhgr mt")

    (test-success "7. encode deep thought"
        equal? encode '("Truth is fiction.")
        "gifgs rhurx grlm")

    (test-success "8. encode all the letters"
        equal? encode '("The quick brown fox jumps over the lazy dog.")
        "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt")

    (test-success "9. decode exercism"
        equal? decode '("vcvix rhn")
        "exercism")

    (test-success "10. decode a sentence"
        equal? decode '("zmlyh gzxov rhlug vmzhg vkkrm thglm v")
        "anobstacleisoftenasteppingstone")

    (test-success "11. decode numbers"
        equal? decode '("gvhgr mt123 gvhgr mt")
        "testing123testing")

    (test-success "12. decode all the letters"
        equal? decode '("gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt")
        "thequickbrownfoxjumpsoverthelazydog")

    (test-success "13. decode with too many spaces"
        equal? decode '("vc vix    r hn")
        "exercism")

    (test-success "14. decode with no spaces"
        equal? decode '("zmlyhgzxovrhlugvmzhgvkkrmthglmv")
        "anobstacleisoftenasteppingstone")
    ))

(run-with-cli "atbash-cipher.scm" (list test-cases))
