(import (rnrs))

; For every Pythagorean triplet with total a + b + c = n,
;     a² + b² = c²
; <=> a² + b² = (n - a - b)², substituting c
; <=> 0 = n² - 2*n*a - 2*n*b + 2*a*b
; <=> (2*n - 2*a) b = (n² - 2*n*a)
; <=> b = (n² - 2*n*a) / (2*n - 2*a)

(define (triplets-with-sum n)
  (if (< n 2)
    '()
    (let loop ((a 1)
               (triplets '()))
      (let* ((numerator (* n (- n a a)))
             (denominator (* 2 (- n a)))
             (b (quotient numerator denominator))
             (c (- n a b)))
        (cond
          ((<= b a)
            (reverse triplets))
          ((zero? (remainder numerator denominator))
            (loop (+ a 1) (cons (list a b c) triplets)))
          (else
            (loop (+ a 1) triplets)))))))
