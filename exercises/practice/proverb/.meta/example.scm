(import (rnrs))

(define (recite strings)
  (if (null? strings)
    ""
    (let loop ((strings (reverse strings))
               (result (list (string-append "And all for the want of a " (car strings) "."))))
      (if (null? (cdr strings))
        (apply string-append result)
        (loop (cdr strings) (cons (string-append "For want of a " (cadr strings) " the " (car strings) " was lost.\n") result))))))
