(import (rnrs))

(define (rebase in-base digits out-base)
  (unless (and (< 1 in-base)
               (< 1 out-base)
               (for-all (lambda (x) (< -1 x in-base)) digits))
    (error 'rebase "invalid base or digit" in-base digits out-base))
  (num->list (list->num digits in-base) out-base))

(define (list->num lst base)
  (fold-left (lambda (sum d) (+ (* sum base) d)) 0 lst))

(define (num->list num base)
  (let loop ([n num] [acc '()])
    (if (< n base)
        (cons n acc)
        (loop (quotient n base) (cons (remainder n base) acc)))))
