(define-module (dna)
  #:export (to-rna))

(define lookup
  '((#\C . #\G)
    (#\G . #\C)
    (#\A . #\U)
    (#\T . #\A)))

;; Example note: there's no explict guard to satisfy the
;; validation test, but the lookup in to-rna will raise
;; an error if the nucleotide is invalid (i.e., not in
;; the above alist), so the test passes.

(define to-rna
  (lambda (dna)
    (let ((dna-seq (string->list dna)))
      (apply string
             (map (lambda (c) (cdr (assoc c lookup))) dna-seq)))))
