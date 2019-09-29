(import (rnrs (6)))

(load "test.scm")

(define (canon word)
  (list-sort char<? (string->list word)))

(define (anagram target words)
  (let ((target (string-downcase target)))
    (filter (lambda (word)
	      (let ((word (string-downcase word)))
		(and (equal? (canon word) (canon target))
		     (not (string=? word target)))))
	    words)))


