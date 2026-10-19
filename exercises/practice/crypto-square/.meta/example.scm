(import (rnrs))

(define (square-root radicand)
  (let loop ((n 0))
    (if (<= radicand (* n n))
        n
        (loop (+ n 1)))))

(define (char-alphanumeric? c)
  (or (char-alphabetic? c)
      (char-numeric? c)))

(define (encipher plaintext)
  (let ((letters (filter char-alphanumeric? (string->list (string-downcase plaintext)))))
    (if (null? letters)
        ""
        (let* ((len (length letters))
               (chunks (square-root len))
               (stride (quotient (+ len chunks chunks -1) chunks))
               (result (make-vector (- (* stride chunks) 1) #\space)))
          (let loop ((index 0)
                     (letters letters))
            (if (null? letters)
                (list->string (vector->list result))
                (let ((index2 (+ (quotient index chunks) (* stride (remainder index chunks)))))
                  (vector-set! result index2 (car letters))
                  (loop (+ index 1) (cdr letters)))))))))
