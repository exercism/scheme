(import (rnrs (6)))

(load "test.scm")

(define (clean-phone-number S)
  (let ((good-char? (lambda (x)
		      (or (char-numeric? x)
			  (memq x (string->list "()+-. "))))))
    (let-values (((goods bads)
		  (partition good-char? (string->list S))))
      (if (not (null? bads))
	  (error 'clean "phone number has junk chars" bads)
	  (list->string
	   (filter char-numeric? goods))))))

(define (split-phone-number S)
  (let* ((S (clean-phone-number S))
	 (digits (string-length S)))
    (cond ((= 10 digits)
	   (values (substring S 0 3)
		   (substring S 3 6)
		   (substring S 6 10)))
	  ((and (= 11 digits) (char=? #\1 (string-ref S 0)))
	   (values (substring S 1 4)
		   (substring S 4 7)
		   (substring S 7 11)))
	  (else (error 'clean "bad phone number" S)))))

(define (clean S)
  (let-values (((code s1 s2) (split-phone-number S)))
    (when (char=? #\0 (string-ref s1 0))
      (error 'clean "bad phone number" S))
    (string-append code s1 s2)))

