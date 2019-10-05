(import (rnrs))

(define (knapsack capacity weights values)
  (branch&bound capacity (map cons weights values)))

(define (branch&bound capacity items)
  (letrec ((best 0)
           ;; include as many items as possible and pretend we can
           ;; take a fraction of the last one. items are ordered by
           ;; density, so this is an upper bound.
           (bound (lambda (capacity items)
                    (cond ((null? items) 0)
                          ((< capacity (item-weight (car items)))
                           (* (density (car items)) capacity))
                          (else
                           (+ (item-value (car items))
                              (bound (- capacity
                                        (item-weight (car items)))
                                     (cdr items)))))))
           ;; search for best knapsack
           (branch (lambda (capacity value items)
                     (when (< best value)
                       (set! best value))
                     (unless (null? items)
                       ;; if we might still improve the best found knapsack
                       (when (<= best (+ value (bound capacity items)))
                         ;; if we can fit the next item
                         (when (<= (item-weight (car items)) capacity)
                           (branch (- capacity (item-weight (car items)))
                                   (+ value (item-value (car items)))
                                   (cdr items)))
                         (branch capacity
                                 value
                                 (cdr items)))))))
    (branch capacity 0 (order-by-density items))
    best))

(define item-weight car)

(define item-value cdr)

(define (density item)
  (/ (item-value item)
     (item-weight item)))

(define (order-by-density items)
  (list-sort (lambda (a b)
               (> (density a)
                  (density b)))
             items))
