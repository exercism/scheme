(load "test-util.ss")

(define test-cases
  `((test-success "Empty RNA sequence" equal? dna->rna '("")
      "")
     (test-success "RNA complement of cytosine is guanine" equal?
       dna->rna '("C") "G")
     (test-success "RNA complement of guanine is cytosine" equal?
       dna->rna '("G") "C")
     (test-success "RNA complement of thymine is adenine" equal?
       dna->rna '("T") "A")
     (test-success "RNA complement of adenine is uracil" equal?
       dna->rna '("A") "U")
     (test-success "RNA complement" equal? dna->rna
       '("ACGTGGTCTTAA") "UGCACCAGAAUU")))

(run-with-cli "rna-transcription.scm" (list test-cases))

