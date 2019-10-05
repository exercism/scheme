(import (rnrs))

(define (hamming-distance strand-a strand-b)
  (when (not (= (string-length strand-a)
		(string-length strand-b)))
    (error 'hamming "unequal strands" strand-a strand-b))
  (length (filter not (map char=?
			   (string->list strand-a)
			   (string->list strand-b)))))

