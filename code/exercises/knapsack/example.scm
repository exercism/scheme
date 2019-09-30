(import (rnrs (6)))

(load "test.scm")

(define (knapsack capacity weights values)
  (branch&bound capacity (map cons weights values)))

(define (branch&bound capacity items)
  (letrec ((best 0)
	   (relaxed-estimate (lambda (capacity value item)
			       (+ value (* (cdr item)
					   capacity
					   (/ (car item))))))
	   (bound (lambda (capacity value items)
		    (do ((items items (cdr items)))
			((or (null? items)
			     (< capacity (caar items)))
			 (if (null? items)
			     value
			     (relaxed-estimate capacity value (car items))))
		      (set! capacity (- capacity (caar items)))
		      (set! value (+ value (cdar items))))))
	   (branch (lambda (capacity value items)
		     (when (< best value)
		       (set! best value))
		     (unless (null? items)
		       (when (<= best (bound capacity value items))
			 (when (<= (caar items) capacity)
			   (branch (- capacity (caar items))
				   (+ value (cdar items))
				   (cdr items)))
			 (branch capacity
				 value
				 (cdr items)))))))
    (branch capacity 0 (order-by-density items))
    best))

(define (order-by-density items)
  (list-sort (lambda (w1.v1 w2.v2)
	       (> (/ (cdr w1.v1) (car w1.v1))
		  (/ (cdr w2.v2) (car w2.v2))))
	     items))





