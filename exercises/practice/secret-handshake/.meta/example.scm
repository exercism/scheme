(import (rnrs))

(define (commands number)
  (define actions '#("wink"
                     "double blink"
                     "close your eyes"
                     "jump"))

  (let ((result (map (lambda (n) (vector-ref actions n))
                     (filter (lambda (n) (< 0 (logand number (ash 1 n))))
                             '(0 1 2 3)))))
    (if (< 0 (logand number 16))
        (reverse result)
        result)))
