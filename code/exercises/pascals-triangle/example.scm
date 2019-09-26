
(define (pascals-triangle n)
  (if (zero? n)
      '()
      (reverse (rows n))))

(define (rows n)
  (if (= n 1)
      '((1))
      (let ((triangle (rows (1- n))))
        (cons (map +
                   `(0 ,@(car triangle))
                   `(,@(car triangle) 0))
              triangle))))
  




