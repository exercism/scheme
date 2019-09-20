
(define (leap-year? year)
  (define (divides-year? x)
    (zero? (modulo year x)))
  (or (and (divides-year? 4)
           (not (divides-year? 100)))
      (divides-year? 400)))
