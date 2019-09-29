(import (rnrs (6)))

(load "test.scm")

(define (scrabble-value char)
  (cond ((memq char (string->list "aeioulnrst")) 1)
	((memq char (string->list "dg")) 2)
	((memq char (string->list "bcmp")) 3)
	((memq char (string->list "fhvwy")) 4)
	((memq char (string->list "k")) 5)
	((memq char (string->list "jx")) 8)
	((memq char (string->list "qz")) 10)
	(else (error 'scrabble-value "idk" char))))

(define (score word)
  (apply + (map scrabble-value (string->list (string-downcase word)))))

