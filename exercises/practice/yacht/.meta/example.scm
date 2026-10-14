(import (rnrs))

(define (xor a b)
  (not (boolean=? a b)))

(define (value-score value dice)
  (apply + (filter (lambda (n) (= n value)) (vector->list dice))))

(define (full-house-score dice)
  (if (and (= (vector-ref dice 0) (vector-ref dice 1))
           (xor (= (vector-ref dice 1) (vector-ref dice 2))
                (= (vector-ref dice 2) (vector-ref dice 3)))
           (= (vector-ref dice 3) (vector-ref dice 4)))
      (apply + (vector->list dice))
      0))

(define (four-of-a-kind-score dice)
  (if (or (= (vector-ref dice 0) (vector-ref dice 3))
          (= (vector-ref dice 1) (vector-ref dice 4)))
      (* 4 (vector-ref dice 2))
      0))

(define (little-straight-score dice)
  (if (equal? dice '#(1 2 3 4 5))
      30
      0))

(define (big-straight-score dice)
  (if (equal? dice '#(2 3 4 5 6))
      30
      0))

(define (choice-score dice)
  (apply + (vector->list dice)))

(define (yacht-score dice)
  (if (= (vector-ref dice 0) (vector-ref dice 4))
      50
      0))

(define (score category dice)
  (let ((dice (vector-sort < dice)))
    (case category
      ((ones) (value-score 1 dice))
      ((twos) (value-score 2 dice))
      ((threes) (value-score 3 dice))
      ((fours) (value-score 4 dice))
      ((fives) (value-score 5 dice))
      ((sixes) (value-score 6 dice))
      ((full-house) (full-house-score dice))
      ((four-of-a-kind) (four-of-a-kind-score dice))
      ((little-straight) (little-straight-score dice))
      ((big-straight) (big-straight-score dice))
      ((choice) (choice-score dice))
      ((yacht) (yacht-score dice))
      (else (error 'score "unknown category" category)))))
