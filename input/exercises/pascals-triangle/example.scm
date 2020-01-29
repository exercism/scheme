(import (rnrs))

(define (pascals-triangle n)
  (build n '(1)))

(define (build n row)
  (if (zero? n)
      '()
      (cons row
            (build (- n 1)
                   (map + `(0 ,@row) `(,@row 0))))))
