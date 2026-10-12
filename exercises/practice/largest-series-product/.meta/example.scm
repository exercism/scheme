(import (rnrs))

(define (product digits start end)
  (let loop ((index start)
             (result 1))
    (if (= index end)
        result
        (loop (+ index 1)
              (* result (- (char->integer (string-ref digits index))
                           (char->integer #\0)))))))

(define (largest-product digits span)
  (cond
   ((exists (lambda (char) (not (char<=? #\0 char #\9))) (string->list digits))
    (error 'largest-product "digits input must only contain digits" digits span))
   ((< span 0)
    (error 'largest-product "span must not be negative" digits span))
   ((< (string-length digits) span)
    (error 'largest-product "span must not exceed string length" digits span))
   (else
    (let loop ((start (- (string-length digits) span))
               (largest 0))
      (if (< start 0)
          largest
          (loop (- start 1) (max largest (product digits start (+ start span)))))))))
