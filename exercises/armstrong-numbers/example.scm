(import (rnrs))

(define (list-digits n)
  (let loop ([n n]
             [ms '()])
    (let-values ([(d m) (div-and-mod n 10)])
      (if (zero? n)
          ms
          (loop d (cons m ms))))))

(define (armstrong-number? n)
  (let* ([digits (list-digits n)]
         [number-of-digits (length digits)])
    (= n
       (apply + (map (lambda (d)
                       (expt d number-of-digits))
                     digits)))))
