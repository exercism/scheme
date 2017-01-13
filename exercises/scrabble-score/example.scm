(define-module (scrabble-score)
  #:export (score))

(define (letter-score letter)
  (case (char-downcase letter)
    [(#\a #\e #\i #\o #\u #\l #\n #\r #\s #\t) 1]
    [(#\d #\g)                                 2]
    [(#\b #\c #\m #\p)                         3]
    [(#\f #\h #\v #\w #\y)                     4]
    [(#\k)                                     5]
    [(#\j #\x)                                 8]
    [(#\q #\z)                                10]
    [else                                      0]))

(define (score word)
  (string-fold (lambda (letter acc) (+ acc (letter-score letter))) 0 word))
