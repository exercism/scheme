(import (rnrs))

(define (rotate phrase dx)
  (list->string
   (map (rotate-char dx)
        (string->list phrase))))

(define (rotate-char dx)
  (lambda (char)
    (let ((rotate-under (lambda (base)
                          (integer->char
                           (+ base
                              (modulo (+ (char->integer char)
                                         dx
                                         (- base))
                                      26))))))
      (cond ((char-lower-case? char)
             (rotate-under 97))
            ((char-upper-case? char)
             (rotate-under 65))
            (else char)))))

