(load "test-util.ss")

(define test-cases
  `((test-success "no name given" equal? two-fer '()
      "One for you, one for me.")
     (test-success "a name given" equal? two-fer '("Alice")
       "One for Alice, one for me.")
     (test-success "another name given" equal? two-fer '("Bob")
       "One for Bob, one for me.")))

(run-with-cli "two-fer.scm" (list test-cases))

