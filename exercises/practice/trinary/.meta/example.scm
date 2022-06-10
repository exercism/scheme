(import (rnrs))

(define (any f xs)
  (fold-left (lambda (r x) (or r (f x))) #f xs))

(define (every f xs)
  (fold-left (lambda (r x) (and r (f x))) #t xs))

(define (string-any f s)
  (any f (string->list s)))

(define (string-every f s)
  (every f (string->list s)))

(define (to-decimal s)
  (call/cc
   (lambda (fail)
    (unless (string-every (lambda (c)
                            (any (lambda (d) (char=? c d))
                                 '(#\0 #\1 #\2)))
                          s)
      (fail 0))
    (apply +
           (map (lambda (d e)
                  (* (- (char->integer d) (char->integer #\0)) (expt 3 e)))
                (reverse (string->list s))
                (iota (string-length s)))))))
