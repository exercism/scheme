(import (rnrs))

(define (contribution char count)
  (let ((digit (- (char->integer char) (char->integer #\0))))
    (cond
     ((zero? (remainder count 2)) digit)
     ((< digit 5) (* 2 digit))
     (else (- (* 2 digit) 9)))))

(define (valid? value)
  (let loop ((chars (reverse (remv #\space (string->list value))))
             (count 0)
             (sum 0))
    (if (null? chars)
        (and (<= 2 count) (zero? (remainder sum 10)))
        (let ((char (car chars)))
          (and (char<=? #\0 char #\9)
               (loop (cdr chars) (+ count 1) (+ sum (contribution char count))))))))
