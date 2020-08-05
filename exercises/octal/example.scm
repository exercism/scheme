(define (to-decimal s)
  (call/cc
   (lambda (return)
     (let loop ([cs (string->list s)]
                [dec 0])
       (cond
        [(null? cs) dec]
        [(char<=? #\0 (car cs) #\7)
         (loop (cdr cs) (+ (* dec 8)
                           (- (char->integer (car cs))
                              (char->integer #\0))))]
        [else (return 0)])))))
