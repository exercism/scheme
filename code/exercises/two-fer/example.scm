(import (rnrs (6)))

(load "test.scm")

(define (two-fer . maybe-name)
  (format #f "One for ~a, one for me."
	  (if (pair? maybe-name)
	      (car maybe-name)
	      "you")))

