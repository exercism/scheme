(import (rnrs))

(define (ignore-char? x)
  (not (or (char-alphabetic? x)
	   (char-numeric? x)
	   (char=? x #\'))))

(define (remove-quotes word)
  (cond ((< (string-length word) 2) word)
	((and (char=? #\' (string-ref word 0))
	      (char=? #\' (string-ref word (1- (string-length word)))))
	 (remove-quotes (substring word 1 (1- (string-length word)))))
	(else word)))

(define (tokenize sentence)
  (let ((n (string-length sentence)))
    (let loop ((a 0) (b 0))
      (cond ((and (= b n) (= a b)) '())
	    ((= b n) (list (remove-quotes (substring sentence a b))))
	    ((ignore-char? (string-ref sentence b))
	     (if (= a b)
		 (loop (1+ a) (1+ b))
		 (cons (remove-quotes (substring sentence a b))
		       (loop (1+ b) (1+ b)))))
	    (else (loop a (1+ b)))))))

(define (word-count sentence)
  (let ((table (make-hashtable string-ci-hash string-ci=?)))
    (for-each (lambda (word)
		(hashtable-set! table
				word
				(1+ (hashtable-ref table word 0))))
	      (tokenize sentence))
    table))

