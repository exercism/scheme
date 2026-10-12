(import (rnrs))

(define (valid? isbn)
  (let loop ((chars (remv #\- (string->list isbn)))
             (weight 10)
             (sum 0))
    (if (null? chars)
        (and (zero? weight) (zero? (remainder sum 11)))
        (let* ((char (car chars))
               (digit (cond
                       ((char<=? #\0 char #\9) (- (char->integer char) (char->integer #\0)))
                       ((and (= 1 weight) (char=? #\X char)) 10)
                       (else #f))))
          (and digit
               (loop (cdr chars) (- weight 1) (+ sum (* weight digit))))))))
