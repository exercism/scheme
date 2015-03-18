;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

(add-to-load-path (dirname (current-filename)))
(use-modules (nucleotide-count))



(test-begin "nucleotide-count")

(test-eqv "empty-dna-strand-has-no-adenine"
          0
          (dna-count #\A ""))

(test-equal "empty-dna-strand-has-no-nucleotides"
            '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0))
            (nucleotide-counts ""))

(test-eqv "repetitive-cytosine-gets-counted"
          5
          (dna-count #\C "CCCCC"))

(test-equal "repetitive-sequence-has-only-guanine"
            '((#\A . 0) (#\C . 0) (#\G . 8) (#\T . 0))
            (nucleotide-counts "GGGGGGGG"))

(test-eqv "counts-only-thymine"
          1
          (dna-count #\T "GGGGGTAACCCGG"))

(test-error "validates-nucleotides"
            #t
            (dna-count #\X "ACGT")
            )

(test-equal "counts-all-nucleotides"
            '((#\A . 20) (#\C . 12) (#\G . 17) (#\T . 21))
            (nucleotide-counts
             "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"))

(test-end "nucleotide-count")
