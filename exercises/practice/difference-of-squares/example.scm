(import (rnrs))

(define (square x)
  (* x x))

(define (square-of-sum n)
  (square (apply + (iota (1+ n)))))

(define (sum-of-squares n)
  (apply + (map square (iota (1+ n)))))

(define (difference-of-squares n)
  (- (square-of-sum n)
     (sum-of-squares n)))

