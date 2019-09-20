(define (encode phrase)
  (apply string-append
	 ((atbash-chunks 5)
	  (map convert
	       (filter relevant-char?
		       (string->list
			 (string-downcase phrase)))))))

(define (decode phrase)
  (list->string
    (map convert
	 (filter relevant-char?
		 (string->list phrase)))))

(define (convert char)
  (if (char-alphabetic? char)
      (integer->char
	(+ 97 (- 122 (char->integer char))))
      char))

(define (relevant-char? char)
  (or (char-alphabetic? char)
      (char-numeric? char)))

(define (atbash-chunks size)
  (lambda (text)
    (define needs-space? #f)
    (let loop ((n (length text)) (text text))
       (if (<= n 0)
	   '()
	   (let ((next (if needs-space?
			   (cons #\space (list-head text (min n size)))
			   (begin
			     (set! needs-space? #t)
			     (list-head text (min n size))))))
	     (cons (list->string next)
		   (loop (- n size) (list-tail text (min n size)))))))))


