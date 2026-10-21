(import (rnrs))

(define (score x y)
  (let ((d2 (+ (* x x) (* y y))))
    (cond ((<= d2 1) 10)
          ((<= d2 25) 5)
          ((<= d2 100) 1)
          (else 0))))
