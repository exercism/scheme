(import (rnrs))

(define (pangram? phrase)
  (let ((phrase (string->list
                 (string-downcase phrase))))
    (let loop ((x 97))
      (if (> x 122)
          #t
          (and (memq (integer->char x)
                     phrase)
               (loop (1+ x)))))))

