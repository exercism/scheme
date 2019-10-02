(import (rnrs (6)))

(load "test.scm")

(define (square n)
  (when (or (< n 0) (> n 64))
    (error 'square "out of range" n))
  (ash 1 (1- n)))

(define total
  (1- (* 2 (square 64))))
