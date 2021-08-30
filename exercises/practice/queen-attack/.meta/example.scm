
(define (attacking? white black)
  (or (same-row? white black)
      (same-column? white black)
      (same-diagonal? white black)))

(define (same-row? a b)
  (= (car a) (car b)))

(define (same-column? a b)
  (= (cadr a) (cadr b)))

(define (same-diagonal? a b)
  (or (= (apply + a) (apply + b))
      (= (apply - a) (apply - b))))



