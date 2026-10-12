(import (rnrs))

(define (prime number)
  (when (zero? number)
    (error 'prime "there is no zeroth prime" number))
  (let* ((size (exact (ceiling (* number (+ (log number)
                                            (log (+ (log number) 8)))))))
         (composite (make-vector size #f)))
    (let loop ((remaining number)
               (p 2))
      (cond
       ((vector-ref composite p) (loop remaining (+ p 1)))
       ((= remaining 1) p)
       (else
        (let mark ((multiple (* p p)))
          (when (< multiple size)
            (vector-set! composite multiple #t)
            (mark (+ multiple p))))
        (loop (- remaining 1) (+ p 1)))))))
