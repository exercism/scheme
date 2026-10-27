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

(define (winner board)
  (define width (div (+ 1 (string-length (vector-ref board 0))) 2))
  (define height (vector-length board))
  (define n (+ 4 (* width height)))
  (define top (- n 4))
  (define bottom (- n 3))
  (define left (- n 2))
  (define right (- n 1))
  (define parents (make-parents n))
  (define ranks (make-ranks n))

  (define (stone r c)
    (string-ref (vector-ref board r) (+ r c c)))

  (define (index r c)
    (+ (* width r) c))

  (define (adjacent r1 c1 r2 c2)
    (when (char=? (stone r1 c1) (stone r2 c2))
      (union parents ranks (index r1 c1) (index r2 c2))))

  (define (edge r c player node)
    (when (char=? (stone r c) player)
      (union parents ranks (index r c) node)))

  ; horizontal -
  (when (< 1 width)
    (let outer ((r height))
      (let ((r (- r 1)))
        (let inner ((c (- width 1)))
          (let ((c (- c 1)))
            (adjacent r c r (+ c 1))
            (if (zero? c)
                (unless (zero? r) (outer r))
                (inner c)))))))

  ; diagonal \
  (when (< 1 height)
    (let outer ((r (- height 1)))
      (let ((r (- r 1)))
        (let inner ((c width))
          (let ((c (- c 1)))
            (adjacent r c (+ r 1) c)
            (if (zero? c)
                (unless (zero? r) (outer r))
                (inner c)))))))

  ; diagonal /
  (when (and (< 1 width) (< 1 height))
    (let outer ((r (- height 1)))
      (let ((r (- r 1)))
        (let inner ((c (- width 1)))
          (let ((c (- c 1)))
            (adjacent r (+ c 1) (+ r 1) c)
            (if (zero? c)
                (unless (zero? r) (outer r))
                (inner c)))))))

  ; O edges
  (let loop ((c width))
    (let ((c (- c 1)))
      (edge 0 c #\O top)
      (edge (- height 1) c #\O bottom)
      (unless (zero? c)
        (loop c))))

  ; X edges
  (let loop ((r height))
    (let ((r (- r 1)))
      (edge r 0 #\X left)
      (edge r (- width 1) #\X right)
      (unless (zero? r)
        (loop r))))

  (cond
    ((= (find parents top) (find parents bottom))
     "O")
    ((= (find parents left) (find parents right))
     "X")
    (else
     "")))
