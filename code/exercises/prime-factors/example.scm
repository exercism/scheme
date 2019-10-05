(import (rnrs))

(define (factorize n)
  (if (even? n)
      (cons 2 (factorize (/ n 2)))
      (let loop ((d 3) (n n))
        (cond ((< n (square d))
               (if (= n 1) '() (list n)))
              ((divides? d n)
               (cons d (loop d (/ n d))))
              (else
               (loop (+ d 2) n))))))

(define (square x)
  (* x x))

(define (divides? d n)
  (zero? (modulo n d)))

