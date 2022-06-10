(load "test-util.ss")

(define test-cases
  `((test-success "basic" equal? acronym
      '("Portable Network Graphics") "PNG")
     (test-success "lowercase words" equal? acronym
       '("Ruby on Rails") "ROR")
     (test-success "punctuation" equal? acronym
       '("First In, First Out") "FIFO")
     (test-success "all caps word" equal? acronym
       '("GNU Image Manipulation Program") "GIMP")
     (test-success "colon" equal? acronym
       '("PHP: Hypertext Preprocessor") "PHP")
     (test-success "punctuation without whitespace" equal? acronym
       '("Complementary metal-oxide semiconductor") "CMOS")
     (test-success "very long abbreviation" equal? acronym
       '("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me")
       "ROTFLSHTMDCOALM")
     (test-success "consecutive delimiters" equal? acronym
       '("Something - I made up from thin air") "SIMUFTA")
     (test-success "apostrophes" equal? acronym
       '("Halley's Comet") "HC")
     (test-success "underscore emphasis" equal? acronym
       '("The Road _Not_ Taken") "TRNT")))

(run-with-cli "acronym.scm" (list test-cases))

