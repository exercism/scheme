(define-module (grains)
  #:export (square total))

(use-modules (srfi srfi-1))

(define (square n)
  (expt 2 (1- n)))

(define (total)
  (reduce + 0 (map square (iota 64 1))))
