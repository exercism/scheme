(import (rnrs (6)))

(load "test.scm")

(define (transpose xs)
  (if (null? xs)
      '()
      (apply map list xs)))

