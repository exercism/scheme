
(define (binary-search array target)
  (let loop ((a 0) (b (1- (vector-length array))))
    (if (> a b)
        'not-found
        (let ((m (ash (+ a b) -1)))
          (cond
           ((< (vector-ref array m) target) (loop (1+ m) b))
           ((> (vector-ref array m) target) (loop a (1- m)))
           (else m))))))
