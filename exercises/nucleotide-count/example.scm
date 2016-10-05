(define-module (nucleotide-count)
  #:export (nucleotide-counts dna-count))


(define validate-nucleotide
  (lambda (nucleotide)
    (if (not (string-any nucleotide "ACGT"))
        (error "Invalid nucleotide"))))

(define dna-count
  (lambda (nucleotide strand)
    (validate-nucleotide nucleotide)
    (string-count strand nucleotide)))

(define nucleotide-counts
  (lambda (strand)
    (let* ((counts '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0)))
           (bases '(#\A #\C #\G #\T)))
      (map (lambda (c) (assoc-set! counts c (dna-count c strand))) bases)
      counts)))
