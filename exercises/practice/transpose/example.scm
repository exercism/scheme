(import (rnrs))

(define (transpose xs)
  (if (null? xs)
      '()
      (apply map list xs)))

