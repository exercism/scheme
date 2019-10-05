(import (rnrs))

(define (square n)
  (when (or (< n 1) (> n 64))
    (error 'square "out of range" n))
  (ash 1 (1- n)))

(define total
  (1- (* 2 (square 64))))
