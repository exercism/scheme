(import (rnrs))

(define (egg-count number)
  (let loop ((number number)
             (acc 0))
    (if (zero? number)
      acc
      (loop (quotient number 2) (+ acc (remainder number 2))))))
