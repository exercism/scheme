(define-module (hamming)
  #:export (hamming-distance))

(define hamming-distance
  (lambda (dna1 dna2)
    (if (eqv? (string-length dna1) (string-length dna2))
        (length
         (filter not
                 (map char=?
                      (string->list dna1)
                      (string->list dna2))))
        (error "String length mismatch."))))
