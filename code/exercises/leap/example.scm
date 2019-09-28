(import (rnrs (6)))

(define (leap-year? year)
  (or (and (zero? (modulo year 4))
	   (not (zero? (modulo year 100))))
      (zero? (modulo year 400))))

