(load "test-util.ss")

(define test-cases
  `((test-success "lowercase letter" = score '("a") 1) (test-success "uppercase letter" = score '("A") 1)
     (test-success "valuable letter" = score '("f") 4)
     (test-success "short word" = score '("at") 2)
     (test-success "short, valuable word" = score '("zoo") 12)
     (test-success "medium word" = score '("street") 6)
     (test-success "medium, valuable word" = score '("quirky")
       22)
     (test-success "long, mixed-case word" = score
       '("OxyphenButazone") 41)
     (test-success "english-like word" = score '("pinata") 8)
     (test-success "empty input" = score '("") 0)
     (test-success "entire alphabet available" = score
       '("abcdefghijklmnopqrstuvwxyz") 87)))

(run-with-cli "scrabble-score.scm" (list test-cases))

