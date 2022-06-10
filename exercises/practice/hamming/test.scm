(load "test-util.ss")

(define test-cases
  `((test-success "empty strands" = hamming-distance '("" "")
      0)
     (test-success "single letter identical strands" =
       hamming-distance '("A" "A") 0)
     (test-success "single letter different strands" =
       hamming-distance '("G" "T") 1)
     (test-success "long identical strands" = hamming-distance
       '("GGACTGAAATCTG" "GGACTGAAATCTG") 0)
     (test-success "long different strands" = hamming-distance
       '("GGACGGATTCTG" "AGGACGGATTCT") 9)
     (test-error
       "disallow first strand longer"
       hamming-distance
       '("AATG" "AAA"))
     (test-error
       "disallow second strand longer"
       hamming-distance
       '("ATA" "AGTG"))
     (test-error
       "disallow left empty strand"
       hamming-distance
       '("" "G"))
     (test-error
       "disallow right empty strand"
       hamming-distance
       '("G" ""))))

(run-with-cli "hamming.scm" (list test-cases))

