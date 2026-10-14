(import (rnrs))

(define (square-root radicand)
  (let loop ((n 0))
    (if (<= radicand (* n n))
      n
      (loop (+ n 1)))))
