(import (rnrs (6)))

(load "test.scm")

(define (leap-year? year)
  (and (zero? (modulo year 4))
       (or (zero? (modulo year 400))
	   (not (zero? (modulo year 100))))))

