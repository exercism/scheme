(import (rnrs))

(define (vertical? column top bottom strings)
  (if (zero? top)
    (let ((ch (string-ref (car strings) column)))
      (and (char=? ch #\+)
           (let loop ((bottom (- bottom 1))
                      (strings (cdr strings)))
             (let ((ch (string-ref (car strings) column)))
               (if (zero? bottom)
                 (char=? ch #\+)
                 (and (or (char=? ch #\+) (char=? ch #\|))
                      (loop (- bottom 1) (cdr strings))))))))
    (vertical? column (- top 1) (- bottom 1) (cdr strings))))

; consider all possible left columns
(define (sweep right top bottom strings)
  (let ((top-string (list-ref strings top))
        (bottom-string (list-ref strings bottom)))
    (let loop ((acc 0)
               (left (- right 1)))
      (if (< left 0)
        acc
        (let ((upper (string-ref top-string left))
              (lower (string-ref bottom-string left)))
          (if (and (or (char=? upper #\+) (char=? upper #\-))
                   (or (char=? lower #\+) (char=? lower #\-)))
            (loop (if (vertical? left top bottom strings) (+ acc 1) acc) (- left 1))
            acc))))))

; consider all possible right columns
(define (scan top bottom columns strings)
  (let loop ((acc 0)
             (right (- columns 1)))
    (cond
      ((zero? right)
        acc)
      ((vertical? right top bottom strings)
        (loop (+ acc (sweep right top bottom strings)) (- right 1)))
      (else
        (loop acc (- right 1))))))

; consider all possible top and bottom rows
(define (rectangles strings)
  (if (or (null? strings) (zero? (string-length (car strings))))
    0
    (let ((columns (string-length (car strings))))
      (let loop ((acc 0)
                 (bottom (- (length strings) 1))
                 (top 0))
        (cond
          ((zero? bottom)
            acc)
          ((= top bottom)
            (loop acc (- bottom 1) 0))
          (else
            (loop (+ acc (scan top bottom columns strings)) bottom (+ top 1))))))))
