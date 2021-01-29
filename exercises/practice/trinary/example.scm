(use-modules (ice-9 regex))

(define (to-decimal s)
  (if (string-match "[^0-2]" s)
      0
      (apply +
             (map (lambda (d e)
                    (* (- (char->integer d) (char->integer #\0)) (expt 3 e)))
                  (reverse (string->list s))
                  (iota (string-length s))))))
