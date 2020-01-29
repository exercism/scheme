
(define (balanced? string)
  (null?
   (fold-right evolve-stack '() (filter bracket? (string->list string)))))

(define (evolve-stack next stack)
  (cond ((null? stack) (list next))
        ((closing? next (car stack)) (cdr stack))
        (else (cons next stack))))

(define (bracket? char)
  (memq char (string->list "{}()[]")))

(define (closing? x y)
  (or (and (eq? x #\() (eq? y #\)))
      (and (eq? x #\[) (eq? y #\]))
      (and (eq? x #\{) (eq? y #\}))))
