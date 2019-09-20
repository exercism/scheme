
(define (sublist xs ys)
  (relate (sort < xs) (sort < ys)))

(define (relate xs ys)
  (cond ((null? xs) (if (null? ys) 'equal 'sublist))
        ((null? ys) 'superlist)
        ((= (car xs) (car ys)) (relate (cdr xs) (cdr ys)))
        ((> (car xs) (car ys)) (proper-sublist? xs (cdr ys)))
        (else (proper-superlist? (cdr xs) ys))))

(define (proper-sublist? xs ys)
  (cond ((null? xs) 'sublist)
        ((null? ys) 'unequal)
        ((eq? (car xs) (car ys))
         (proper-sublist? (cdr xs) (cdr ys)))
        ((< (car xs) (car ys)) 'unequal)
        (else (proper-sublist? xs (cdr ys)))))

(define (proper-superlist? xs ys)
  (cond ((null? xs) (if (null? ys) 'superlist 'unequal))
        ((null? ys) 'superlist)
        ((eq? (car xs) (car ys))
         (proper-superlist? (cdr xs) (cdr ys)))
        ((> (car xs) (car ys)) 'unequal)
        (else (proper-sublist? (cdr xs) ys))))



