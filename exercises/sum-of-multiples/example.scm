(use-modules (srfi srfi-1))

(define (sum-of-multiples ints limit)
  (apply + (filter (lambda (n)
                     (any (lambda (i)
                            (zero? (remainder n i)))
                          (delete 0 ints)))
                   (cdr (iota limit)))))
