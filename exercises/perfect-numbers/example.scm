(import (rnrs))

(define (classify n)
  (when (or (< n 1) (not (integer? n)))
    (error 'classify "not a natural number" n))
  (let ((D-n (- (apply + (divisors n)) n)))
    (cond ((< D-n n) 'deficient)
          ((> D-n n) 'abundant)
          (else 'perfect))))

(define (divisors n)
  (fold-left (lambda (xs y)
               (nub-merge xs (map (lambda (x)
                                    (* x y))
                                  xs)))
             '(1)
             (factorize n)))

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

(define (nub-merge xs ys)
  (if (null? xs)
      ys
      (cond ((< (car xs) (car ys))
             (cons (car xs) (nub-merge (cdr xs) ys)))
            ((> (car xs) (car ys))
             (cons (car ys) (nub-merge (cdr ys) xs)))
            (else (cons (car xs) (nub-merge (cdr xs) (cdr ys)))))))

(define (square x)
  (* x x))

(define (divides? d n)
  (zero? (modulo n d)))
