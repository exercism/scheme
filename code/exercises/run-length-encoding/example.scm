(import (rnrs))

(load "test.scm")

(define (encode s)
  (apply string-append
         (map (lambda (group)
                (let ((n (length group)))
                  (if (= n 1)
                      (string (car group))
                      (format "~a~a" (length group) (car group)))))
              (grouping char=? (string->list s)))))

(define (decode s)
  (let loop ((groups '()) (i 0))
    (cond ((>= i (string-length s))
           (apply string-append (reverse groups)))
          ((char-numeric? (string-ref s i))
           (let ((n (get-number s i)))
             (loop (cons (make-string (string->number n)
                                      (string-ref s (+ i (string-length n))))
                         groups)
                   (+ i (string-length n) 1))))
          (else (loop (cons (string (string-ref s i)) groups)
                      (1+ i))))))

(define (get-number s i)
  (let loop ((j i))
    (cond ((= i (string-length s))
           (substring s i j))
          ((not (char-numeric? (string-ref s j)))
           (substring s i j))
          (else
           (loop (1+ j))))))

(define (grouping pred symbols)
  (if (null? symbols)
      symbols
      (let loop ((x (car symbols))
                 (symbols (cdr symbols))
                 (next (list-head symbols 1))
                 (groups '()))
        (cond ((null? symbols)
               (reverse (cons next groups)))
              ((pred x (car symbols))
               (loop (car symbols)
                     (cdr symbols)
                     (cons (car symbols) next)
                     groups))
              (else
               (loop (car symbols)
                     (cdr symbols)
                     (list (car symbols))
                     (cons (reverse next) groups)))))))
