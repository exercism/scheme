(use-modules (ice-9 regex))

(define (acronym text)
  (apply (compose string-upcase string-append)
         (map (lambda (ss)
                (string-take (match:substring ss) 1))
              (list-matches "[[:alpha:]|']+" text))))
