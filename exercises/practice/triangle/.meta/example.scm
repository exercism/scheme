(import (rnrs))

(define (any f xs)
  (fold-left (lambda (r x) (or r (f x))) #f xs))

(define (every f xs)
  (fold-left (lambda (r x) (and r (f x))) #t xs))

(define (string-any f s)
  (any f (string->list s)))

(define (string-every f s)
  (every f (string->list s)))

(define (nub xs)
  (fold-left (lambda (ys x)
               (if (any (lambda (y) (equal? x y)) ys) ys
                   (cons x ys)))
             '() xs))

(define (impl-safe-sort f xs)
  (call/cc
   (lambda (k)
     (with-exception-handler
         (lambda (e)
           ;; Uh-oh, we're using Guile!
           (k (sort xs f)))
       (lambda ()
         (sort f xs))))))

(define (triangle a b c)
  (let ([xs (impl-safe-sort > (list a b c))])
    (if (>= (car xs) (apply + (cdr xs)))
        (error "Invalid triangle")
        (case (length (nub xs))
          [(1) 'equilateral]
          [(2) 'isosceles]
          [else 'scalene]))))
