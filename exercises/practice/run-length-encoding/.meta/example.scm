(import (rnrs))

(define (prepend-length len chars)
  (if (zero? len)
      chars
      (prepend-length (quotient len 10)
                      (cons (integer->char (+ (char->integer #\0) (remainder len 10)))
                            chars))))

(define (prepend-run len char chars)
  (if (zero? len)
      chars
      (prepend-run (- len 1) char (cons char chars))))

(define (encode string)
  (let loop ((index (- (string-length string) 1))
             (len 1)
             (chars '()))
    (cond
     ((< index 0)
      (list->string chars))
     ((and (< 0 index)
           (char=? (string-ref string (- index 1)) (string-ref string index)))
      (loop (- index 1) (+ len 1) chars))
     ((= len 1)
      (loop (- index 1) 1 (cons (string-ref string index) chars)))
     (else
      (loop (- index 1) 1 (prepend-length len (cons (string-ref string index) chars)))))))

(define (decode string)
  (let loop ((index 0)
             (len 0)
             (chars '()))
    (cond
     ((= index (string-length string))
      (list->string (reverse chars)))
     ((char<=? #\0 (string-ref string index) #\9)
      (loop (+ index 1)
            (+ (* len 10) (- (char->integer (string-ref string index)) (char->integer #\0)))
            chars))
     (else
      (loop (+ index 1) 0 (prepend-run (max len 1) (string-ref string index) chars))))))
