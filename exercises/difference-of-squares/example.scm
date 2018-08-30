(define-module (squares)
  #:export (sum-of-squares
            square-of-sum
            difference)
  #:autoload (srfi srfi-1) (reduce iota))


(define sum-of-squares
  (lambda (n)
    (reduce + 0 (map (lambda (i) (expt i 2)) (iota n 1)))))

(define square-of-sum
  (lambda (n)
    (expt (reduce + 0 (iota n 1)) 2)))

(define difference
  (lambda (n)
    (- (square-of-sum n)
       (sum-of-squares n))))
