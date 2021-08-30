(import (rnrs))

(define (convert number)
  (let* ((rules '((3 . "Pling") (5 . "Plang") (7 . "Plong")))
	 (helper (lambda (k.w word)
		   (if (zero? (modulo number (car k.w)))
		       (string-append (cdr k.w) word)
		       word)))
	 (result (fold-right helper "" rules)))
    (if (equal? "" result)
	(number->string number)
	result)))

