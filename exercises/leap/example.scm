(import (rnrs (6)))

(load "test.scm")

(define (leap-year? year)
  (and (zero? (modulo year 4))
       (or (not (zero? (modulo year 100)))
           (zero? (modulo year 400)))))

