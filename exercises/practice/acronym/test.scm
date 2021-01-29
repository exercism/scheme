(load "acronym.scm")

(use-modules (srfi srfi-64))

(test-begin "acronym")

; (test-skip "basic")
(test-equal "basic"
  (acronym "Portable Network Graphics")
  "PNG")

(test-skip "lowercase words")
(test-equal "lowercase words"
  (acronym "Ruby on Rails")
  "ROR")

(test-skip "punctuation")
(test-equal "punctuation"
  (acronym "First In, First Out")
  "FIFO")

(test-skip "all caps words")
(test-equal "all caps word"
  (acronym "GNU Image Manipulation Program")
  "GIMP")

(test-skip "colon")
(test-equal "colon"
  (acronym "PHP: Hypertext Preprocessor")
  "PHP")

(test-skip "punctuation without whitespace")
(test-equal "punctuation without whitespace"
  (acronym "Complementary metal-oxide semiconductor")
  "CMOS")

(test-skip "very long abbreviation")
(test-equal "very long abbreviation"
  (acronym "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me")
  "ROTFLSHTMDCOALM")

(test-skip "consecutive delimiters")
(test-equal "consecutive delimiters"
  (acronym "Something - I made up from thin air")
  "SIMUFTA")

(test-skip "apostrophes")
(test-equal "apostrophes"
  (acronym "Halley's Comet")
  "HC")

(test-skip "underscore emphasis")
(test-equal "underscore emphasis"
  (acronym "The Road _Not_ Taken")
  "TRNT")

(test-end "acronym")
