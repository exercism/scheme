(load "test-util.ss")

(define test-cases
  `((test-success "encode yes" equal? encode '("yes") "bvh") (test-success "encode no" equal? encode '("no") "ml")
     (test-success "encode OMG" equal? encode '("OMG") "lnt")
     (test-success "encode spaces" equal? encode '("O M G")
       "lnt")
     (test-success "encode mindblowingly" equal? encode
       '("mindblowingly") "nrmwy oldrm tob")
     (test-success "encode numbers" equal? encode
       '("Testing,1 2 3, testing.") "gvhgr mt123 gvhgr mt")
     (test-success "encode deep thought" equal? encode
       '("Truth is fiction.") "gifgs rhurx grlm")
     (test-success "encode all the letters" equal? encode
       '("The quick brown fox jumps over the lazy dog.")
       "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt")
     (test-success "decode exercism" equal? decode '("vcvix rhn")
       "exercism")
     (test-success "decode a sentence" equal? decode
       '("zmlyh gzxov rhlug vmzhg vkkrm thglm v")
       "anobstacleisoftenasteppingstone")
     (test-success "decode numbers" equal? decode
       '("gvhgr mt123 gvhgr mt") "testing123testing")
     (test-success "decode all the letters" equal? decode
       '("gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt")
       "thequickbrownfoxjumpsoverthelazydog")
     (test-success "decode with too many spaces" equal? decode
       '("vc vix    r hn") "exercism")
     (test-success "decode with no spaces" equal? decode
       '("zmlyhgzxovrhlugvmzhgvkkrmthglmv")
       "anobstacleisoftenasteppingstone")))

(run-with-cli "atbash-cipher.scm" (list test-cases))

