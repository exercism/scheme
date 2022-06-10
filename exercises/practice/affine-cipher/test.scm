(load "test-util.ss")

(define test-cases
  `((test-success "encode yes" equal? encode '((5 . 7) "yes")
      "xbt")
     (test-success "encode no" equal? encode '((15 . 18) "no")
       "fu")
     (test-success "encode OMG" equal? encode '((21 . 3) "OMG")
       "lvz")
     (test-success "encode O M G" equal? encode
       '((25 . 47) "O M G") "hjp")
     (test-success "encode mindblowingly" equal? encode
       '((11 . 15) "mindblowingly") "rzcwa gnxzc dgt")
     (test-success "encode numbers" equal? encode
       '((3 . 4) "Testing,1 2 3, testing.") "jqgjc rw123 jqgjc rw")
     (test-success "encode deep thought" equal? encode
       '((5 . 17) "Truth is fiction.") "iynia fdqfb ifje")
     (test-success "encode all the letters" equal? encode
       '((17 . 33) "The quick brown fox jumps over the lazy dog.")
       "swxtj npvyk lruol iejdc blaxk swxmh qzglf")
     (test-error
       "encode with a not coprime to m"
       encode
       '(((a . 6) (b . 17)) "This is a test."))
     (test-success "decode exercism" equal? decode
       '((3 . 7) "tytgn fjr") "exercism")
     (test-success "decode a sentence" equal? decode
       '((19 . 16) "qdwju nqcro muwhn odqun oppmd aunwd o")
       "anobstacleisoftenasteppingstone")
     (test-success "decode numbers" equal? decode
       '((25 . 7) "odpoz ub123 odpoz ub") "testing123testing")
     (test-success "decode all the letters" equal? decode
       '((17 . 33) "swxtj npvyk lruol iejdc blaxk swxmh qzglf")
       "thequickbrownfoxjumpsoverthelazydog")
     (test-success "decode with no spaces in input" equal? decode
       '((17 . 33) "swxtjnpvyklruoliejdcblaxkswxmhqzglf")
       "thequickbrownfoxjumpsoverthelazydog")
     (test-success "decode with too many spaces" equal? decode
       '((15 . 16) "vszzm    cly   yd cg    qdp")
       "jollygreengiant")
     (test-error
       "decode with a not coprime to m"
       decode
       '(((a . 13) (b . 5)) "Test"))))

(run-with-cli "affine-cipher.scm" (list test-cases))

