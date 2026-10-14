(import (rnrs))

(define (plant letter)
  (case letter
    ((#\G) "grass")
    ((#\C) "clover")
    ((#\R) "radishes")
    ((#\V) "violets")
    (else (error 'plants "diagram contains unknown plant" letter))))

(define (plants diagram student)
  (let ((m (quotient (+ (string-length diagram) 1) 2))
        (n (* 2 (- (char->integer (string-ref student 0))
                   (char->integer #\A)))))
    (map (lambda (index) (plant (string-ref diagram index)))
         (list n (+ n 1) (+ m n) (+ m n 1)))))
