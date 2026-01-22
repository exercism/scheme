(define (is-prefix-of? xs ys)
  (cond
   [(null? xs) #t]
   [(null? ys) #f]
   [(equal? (car xs) (car ys)) (is-prefix-of? (cdr xs) (cdr ys))]
   [else #f]))

(define (sublist-of? xs ys)
  (if (and (not (null? xs))
           (null? ys))
      #f
      (or (is-prefix-of? xs ys)
          (sublist-of? xs (cdr ys)))))

(define (sublist xs ys)
  (let ([sub (sublist-of? xs ys)]
        [super (sublist-of? ys xs)])
    (cond
     [(and sub super) 'equal]
     [sub 'sublist]
     [super 'superlist]
     [else 'unequal])))
