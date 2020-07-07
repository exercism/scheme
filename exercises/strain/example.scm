(define (keep pred seq)
  (cond
   [(null? seq) '()]
   [(pred (car seq)) (cons (car seq)
                           (keep pred (cdr seq)))]
   [else (keep pred (cdr seq))]))

(define (discard pred seq)
  (keep (compose not pred) seq))
