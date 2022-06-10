(load "test-util.ss")

(define test-cases
  `((test-success "empty sentence" eq? pangram? '("") #f)
     (test-success "perfect lower case" eq? pangram?
       '("abcdefghijklmnopqrstuvwxyz") #t)
     (test-success "only lower case" eq? pangram?
       '("the quick brown fox jumps over the lazy dog") #t)
     (test-success "missing the letter 'x'" eq? pangram?
       '("a quick movement of the enemy will jeopardize five gunboats")
       #f)
     (test-success "missing the letter 'h'" eq? pangram?
       '("five boxing wizards jump quickly at it") #f)
     (test-success "with underscores" eq? pangram?
       '("the_quick_brown_fox_jumps_over_the_lazy_dog") #t)
     (test-success "with numbers" eq? pangram?
       '("the 1 quick brown fox jumps over the 2 lazy dogs") #t)
     (test-success "missing letters replaced by numbers" eq? pangram?
       '("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog") #f)
     (test-success "mixed case and punctuation" eq? pangram?
       '("\"Five quacking Zephyrs jolt my wax bed.\"") #t)
     (test-success "case insensitive" eq? pangram?
       '("the quick brown fox jumps over with lazy FX") #f)))

(run-with-cli "pangram.scm" (list test-cases))

