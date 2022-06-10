(load "test-util.ss")

(define test-cases
  `((test-success "stating something" equal? response-for
      '("Tom-ay-to, tom-aaaah-to.") "Whatever.")
    (test-success "shouting" equal? response-for '("WATCH OUT!")
      "Whoa, chill out!")
    (test-success "shouting gibberish" equal? response-for
      '("FCECDFCAAB") "Whoa, chill out!")
    (test-success "asking a question" equal? response-for
      '("Does this cryogenic chamber make me look fat?") "Sure.")
    (test-success "asking a numeric question" equal?
      response-for '("You are, what, like 15?") "Sure.")
    (test-success "asking gibberish" equal? response-for
      '("fffbbcbeab?") "Sure.")
    (test-success "talking forcefully" equal? response-for
      '("Hi there!") "Whatever.")
    (test-success "using acronyms in regular speech" equal? response-for
      '("It's OK if you don't want to go work for NASA.")
      "Whatever.")
    (test-success "forceful question" equal? response-for
      '("WHAT'S GOING ON?") "Calm down, I know what I'm doing!")
    (test-success "shouting numbers" equal? response-for
      '("1, 2, 3 GO!") "Whoa, chill out!")
    (test-success "no letters" equal? response-for '("1, 2, 3")
      "Whatever.")
    (test-success "question with no letters" equal? response-for
      '("4?") "Sure.")
    (test-success "shouting with special characters" equal? response-for
      '("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")
      "Whoa, chill out!")
    (test-success "shouting with no exclamation mark" equal?
      response-for '("I HATE THE DENTIST") "Whoa, chill out!")
    (test-success "statement containing question mark" equal? response-for
      '("Ending with ? means a question.") "Whatever.")
    (test-success "non-letters with question" equal?
      response-for '(":) ?") "Sure.")
    (test-success "prattling on" equal? response-for
      '("Wait! Hang on. Are you going to be OK?") "Sure.")
    (test-success "silence" equal? response-for '("")
      "Fine. Be that way!")
    (test-success "prolonged silence" equal? response-for
      '("          ") "Fine. Be that way!")
    (test-success "alternate silence" equal? response-for
      '("\t\t\t\t\t\t\t\t\t\t") "Fine. Be that way!")
    (test-success "multiple line question" equal? response-for
      '("\nDoes this cryogenic chamber make me look fat?\nNo.")
      "Whatever.")
    (test-success "starting with whitespace" equal? response-for
      '("         hmmmmmmm...") "Whatever.")
    (test-success "ending with whitespace" equal? response-for
      '("Okay if like my  spacebar  quite a bit?   ") "Sure.")
    (test-success "other whitespace" equal? response-for
      '("\n\r \t") "Fine. Be that way!")
    (test-success "non-question ending with whitespace" equal? response-for
      '("This is a statement ending with whitespace      ")
      "Whatever.")))

(run-with-cli "bob.scm" (list test-cases))

