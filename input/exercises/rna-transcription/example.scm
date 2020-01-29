(import (rnrs))

(define (dna->rna dna)
  (list->string
   (map (lambda (nucleotide)
	  (case nucleotide
	    ((#\G) #\C)
	    ((#\C) #\G)
	    ((#\T) #\A)
	    ((#\A) #\U)))
	(string->list dna))))

