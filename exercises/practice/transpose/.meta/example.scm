(import (rnrs))

;; Pad each line on the right to the length of the longest line at or
;; below it, so the padded lengths never increase going down. Column i
;; of the result then comes from the lines long enough to have an i-th
;; character, and those lines always form a prefix.
(define (transpose lines)
  (let* ((widths (fold-right (lambda (line below)
                               (cons (max (string-length line)
                                          (if (null? below) 0 (car below)))
                                     below))
                             '()
                             lines))
         (padded (map pad-right lines widths))
         (n (if (null? widths) 0 (car widths))))
    (let loop ((i (- n 1)) (rows '()))
      (if (< i 0)
          rows
          (loop (- i 1) (cons (column padded i) rows))))))

(define (pad-right line width)
  (string-append line
                 (make-string (- width (string-length line)) #\space)))

(define (column lines i)
  (list->string
   (map (lambda (line) (string-ref line i))
        (filter (lambda (line) (< i (string-length line)))
                lines))))
