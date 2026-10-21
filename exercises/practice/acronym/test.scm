; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/acronym/canonical-data.json
; File last updated on 2026-10-21T18:49:09+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. basic"
        equal? acronym '("Portable Network Graphics")
        "PNG")

    (test-success "2. lowercase words"
        equal? acronym '("Ruby on Rails")
        "ROR")

    (test-success "3. punctuation"
        equal? acronym '("First In, First Out")
        "FIFO")

    (test-success "4. all caps word"
        equal? acronym '("GNU Image Manipulation Program")
        "GIMP")

    (test-success "5. punctuation without whitespace"
        equal? acronym '("Complementary metal-oxide semiconductor")
        "CMOS")

    (test-success "6. very long abbreviation"
        equal? acronym '("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me")
        "ROTFLSHTMDCOALM")

    (test-success "7. consecutive delimiters"
        equal? acronym '("Something - I made up from thin air")
        "SIMUFTA")

    (test-success "8. apostrophes"
        equal? acronym '("Halley's Comet")
        "HC")

    (test-success "9. underscore emphasis"
        equal? acronym '("The Road _Not_ Taken")
        "TRNT")

    (test-success "10. colon"
        equal? acronym '("PHP: Hypertext Preprocessor")
        "PHP")
    ))

(run-with-cli "acronym.scm" (list test-cases))
