(define (roman n)
  (let loop ([n n]
             [r '((1000 . "M")
                  (900 . "CM")
                  (500 . "D")
                  (400 . "CD")
                  (100 . "C")
                  (90 . "XC")
                  (50 . "L")
                  (40 . "XL")
                  (10 . "X")
                  (9 . "IX")
                  (5 . "V")
                  (4 . "IV")
                  (1 . "I"))])
    (cond
     [(zero? n) ""]
     [(>= n (caar r)) (string-append (cdar r)
                                     (loop (- n (caar r)) r))]
     [else (loop n (cdr r))])))

;;; Or, alternatively ...
;;
;; (use-modules (ice-9 format))
;;
;; (define (roman n)
;;   (format #f "~@r" n))
