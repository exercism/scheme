
(define (hamming-distance x y)
  (unless (= (string-length x) (string-length y))
    (error 'hamming-distance "invalid inputs arguments" x y))
  (length
    (filter not
	    (map char=?
		 (string->list x)
		 (string->list y)))))
