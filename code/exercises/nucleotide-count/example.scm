
(define (nucleotide-count dna)
  (let ((table (make-hash-table)))
    (string-for-each (lambda (nucleotide)
		       (unless (memq nucleotide (string->list "ACGT"))
			 (error 'nucleotide-count "not a nucleotide" nucleotide))
		       (hashtable-set! table
				       nucleotide
				       (1+ (hashtable-ref table nucleotide 0))))
		     dna)
    (vector->list (hashtable-cells table))))

