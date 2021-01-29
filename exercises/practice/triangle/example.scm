(use-modules (srfi srfi-1))

(define (triangle a b c)
  (let ([xs (sort (list a b c) >)])
    (if (>= (car xs) (apply + (cdr xs)))
        (error "Invalid triangle")
        (case (length (delete-duplicates xs))
          [(1) 'equilateral]
          [(2) 'isosceles]
          [else 'scalene]))))
