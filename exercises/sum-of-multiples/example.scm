(use-modules (srfi srfi-1))

(define (sum-of-multiples ints limit)
  (let ([ints-0 (delete 0 ints)])
    (if (null? ints-0)
        0
        (apply + (filter (lambda (n)
                           (any (lambda (i)
                                  (zero? (remainder n i)))
                                ints-0))
                         (cdr (iota limit)))))))
