(import (rnrs))

(define (recite-verse verse)
  (define animals
    '#(""
       "fly"
       "spider"
       "bird"
       "cat"
       "dog"
       "goat"
       "cow"
       "horse"))

  (define exclamations
    '#(""
       "I don't know why she swallowed the fly. Perhaps she'll die."
       "It wriggled and jiggled and tickled inside her.\n"
       "How absurd to swallow a bird!\n"
       "Imagine that, to swallow a cat!\n"
       "What a hog, to swallow a dog!\n"
       "Just opened her throat and swallowed a goat!\n"
       "I don't know how she swallowed a cow!\n"
       "She's dead, of course!"))

  (define first-line
    (string-append "I know an old lady who swallowed a " (vector-ref animals verse) ".\n"))

  (define exclamation (vector-ref exclamations verse))

  (define (suffix index)
    (if (= index 2)
      " that wriggled and jiggled and tickled inside her"
      ""))

  (if (< 1 verse 8)
    (let loop ((index 1)
               (result (vector-ref exclamations 1)))
      (if (= index verse)
        (string-append first-line exclamation result)
        (loop (+ index 1)
              (string-append "She swallowed the " (vector-ref animals (+ index 1))
                             " to catch the " (vector-ref animals index) (suffix index) ".\n"
                             result))))
    (string-append first-line exclamation)))

(define (recite start-verse end-verse)
  (let loop ((verse end-verse)
             (result '()))
    (let ((result (cons (recite-verse verse) result)))
      (if (= verse start-verse)
        (apply string-append result)
        (loop (- verse 1) (cons "\n\n" result))))))
