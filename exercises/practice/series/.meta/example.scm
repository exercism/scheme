(import (rnrs))

(define (slices series slice-length)
  (cond
   ((zero? slice-length)
    (error 'slices "slice length cannot be zero" series slice-length))
   ((< slice-length 0)
    (error 'slices "slice length cannot be negative" series slice-length))
   ((zero? (string-length series))
    (error 'slices "series cannot be empty" series slice-length))
   ((< (string-length series) slice-length)
    (error 'slices "slice length cannot be greater than series length"
           series slice-length))
   (else
    (let loop ((start (- (string-length series) slice-length))
               (result '()))
      (if (< start 0)
          result
          (loop (- start 1)
                (cons (substring series start (+ start slice-length)) result)))))))
