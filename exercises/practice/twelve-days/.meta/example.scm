(import (rnrs))

(define (recite-verse verse)
  (string-append
    "On the "
    (list-ref '("" "first" "second" "third" "fourth" "fifth" "sixth" "seventh" "eighth" "ninth" "tenth" "eleventh" "twelfth") verse)
    " day of Christmas my true love gave to me: "
    (substring
      "twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      (list-ref '(0 235 213 194 174 157 137 113 90 69 48 26 0) verse)
      262)))

(define (recite start-verse end-verse)
  (let loop ((verse end-verse)
             (result '()))
    (let ((result (cons (recite-verse verse) result)))
      (if (= verse start-verse)
        (apply string-append result)
        (loop (- verse 1) (cons "\n" result))))))
