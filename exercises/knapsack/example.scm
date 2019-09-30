(import (rnrs (6)))

(load "test.scm")

(define (greedy-order weight-value-pairs)
  (list-sort (lambda (w1.v1 w2.v2)
	       (> (/ (cdr w1.v1) (car w1.v1))
		  (/ (cdr w2.v2) (car w2.v2))))
	     weight-value-pairs))

(define (knapsack capacity weights values)
  (branch&bound capacity
		(greedy-order (map cons weights values))))


(define (branch&bound capacity weights-values)
  (define best 0)
  (define (bound capacity value weights-values)
    (do ((weights-values weights-values (cdr weights-values)))
	((or (null? weights-values)
	     (< capacity (caar weights-values)))
	 (if (null? weights-values)
	     value
	     (+ value (* (cdar weights-values)
			 capacity
			 (/ (caar weights-values))))))
      (set! capacity (- capacity (caar weights-values)))
      (set! value (+ value (cdar weights-values)))))
  (let branch ((capacity capacity)
	       (total 0)
	       (weights-values weights-values))
    (when (< best total)
      (set! best total))
    (unless (null? weights-values)
      (when (<= best (bound capacity total weights-values))
	(when (<= (caar weights-values) capacity)
	  (branch (- capacity (caar weights-values))
		  (+ total (cdar weights-values))
		  (cdr weights-values)))
	(branch capacity
		total
		(cdr weights-values)))))
  best)




