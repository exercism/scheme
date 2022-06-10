(import (rnrs))

(define (delete x xs)
  (filter (lambda (y) (not (equal? x y))) xs))

(define (any f xs)
  (fold-left (lambda (r x) (or r (f x))) #f xs))

(define (sum-of-multiples ints limit)
  (apply + (filter (lambda (n)
                     (any (lambda (i)
                              (zero? (remainder n i)))
                            (delete 0 ints)))
                   (cdr (iota limit)))))
