(import (rnrs))

(define (make-parents n)
  (let ((parents (make-vector n)))
    (let loop ((i n))
      (let ((i (- i 1)))
        (vector-set! parents i i)
        (if (zero? i)
            parents
            (loop i))))))

(define (make-ranks n)
  (make-vector n 0))

(define (find parents node)
  (let loop ((node node)
             (parent (vector-ref parents node)))
    (if (= parent node)
        node
        (let ((grandparent (vector-ref parents parent)))
          (vector-set! parents node grandparent)
          (loop parent grandparent)))))

(define (union parents ranks a b)
  (let ((a (find parents a))
        (b (find parents b)))
    (cond
      ((= a b))
      ((< (vector-ref ranks a) (vector-ref ranks b))
       (vector-set! parents a b))
      ((< (vector-ref ranks b) (vector-ref ranks a))
       (vector-set! parents b a))
      (else
       (vector-set! ranks b (+ 1 (vector-ref ranks b)))
       (vector-set! parents a b)))))

(define (can-chain? . dominoes)
  (define n (if (null? dominoes) 1 (+ 1 (apply max (map (lambda (stone) (max (car stone) (cdr stone))) dominoes)))))
  (define parents (make-parents n))
  (define ranks (make-ranks n))
  (define tally (make-vector n 0))

  (for-each
    (lambda (stone)
      (let ((a (car stone))
            (b (cdr stone)))
        (vector-set! tally a (+ 1 (vector-ref tally a)))
        (vector-set! tally b (+ 1 (vector-ref tally b)))
        (union parents ranks a b)))
    dominoes)

  (let loop ((index 0)
             (root #f))
    (cond
      ((= index n)
        #t)
      ((= 1 (mod (vector-ref tally index) 2))
        #f)
      ((or (zero? (vector-ref tally index)) (not (= index (vector-ref parents index))))
        (loop (+ 1 index) root))
      (root
        #f)
      (else
        (loop (+ 1 index) index)))))
