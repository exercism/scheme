(import (rnrs))

(define (recite-verse verse)
  (let ((lyrics "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")
        (table #(0 389 368 351 331 310 267 232 190 145 99 62 8)))
    (string-append
      (substring lyrics 0 8)
      (substring lyrics (vector-ref table verse) 415))))

(define (recite start-verse end-verse)
  (let loop ((verse end-verse)
             (result '()))
    (let ((result (cons (recite-verse verse) result)))
      (if (= verse start-verse)
        (apply string-append result)
        (loop (- verse 1) (cons "\n" result))))))
