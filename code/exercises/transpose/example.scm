(import (rnrs (6)))

(load "test.scm")

(define (transpose lst)
  (if (null? lst)
      '()
      (map list->string
           (apply map
                  list
                  (map string->list lst)))))

