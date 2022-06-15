(import (rnrs))

(define (acronym text)
  (with-output-to-string
    (lambda ()
      (let go ((xs (string->list text)))
        (let-values (((word rest)
                      (snoc-while relevant? (drop-while not-relevant? xs))))
          (unless (null? word)
            (put-char (current-output-port) (char-upcase (car word))))
          (unless (null? rest)
            (go rest)))))))

(define (relevant? c)
  (or (char-alphabetic? c) (char=? c #\')))

(define (not-relevant? c)
  (not (relevant? c)))

(define (drop-while p xs)
  (cond
   ((null? xs) xs)
   ((p (car xs)) (drop-while p (cdr xs)))
   (else xs)))

(define (snoc-while p xs)
  (let go ((xs* xs) (taken '()))
    (if (and (not (null? xs*)) (p (car xs*)))
        (go (cdr xs*) (cons (car xs*) taken))
        (values (reverse taken) xs*))))
