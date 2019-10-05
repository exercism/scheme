(import (rnrs))

(define (canonicalize word)
  (list-sort char<? (string->list word)))

(define (anagram target words)
  (let ((target (string-downcase target)))
    (filter (lambda (word)
              (let ((word (string-downcase word)))
                (and (equal? (canonicalize word) (canonicalize target))
                     (not (equal? word target)))))
            words)))


