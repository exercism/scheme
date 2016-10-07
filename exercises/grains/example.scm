(define-module (grains)
  #:export (square total)
  #:autoload (srfi srfi-1) (iota))

(define (square n)
  (expt 2 (1- n)))

(define (total)
  (reduce + 0 (map square (iota 64 1))))
