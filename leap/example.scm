(define-module (leap-year)
  #:export (leap-year?))

(define leap-year?
  (lambda (year)
    (and (= (modulo year 4) 0)
         (or (not (= (modulo year 100) 0))
             (= (modulo year 400) 0)))))
