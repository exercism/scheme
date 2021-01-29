(import (rnrs))

(define (nucleotide-count dna)
  (let ((table (make-eq-hashtable)))
    (for-each (lambda (nucleotide)
                (unless (memq nucleotide (string->list "ACGT"))
                  (error 'nucleotide-count "not a nucleotide" nucleotide))
                (hashtable-set! table
                                nucleotide
                                (1+ (hashtable-ref table nucleotide 0))))
              (string->list dna))
    (let-values (((neucleotides counts)
                  (hashtable-entries table)))
      (vector->list
       (vector-map cons neucleotides counts)))))

