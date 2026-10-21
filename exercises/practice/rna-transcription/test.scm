; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/rna-transcription/canonical-data.json
; File last updated on 2026-10-21T17:08:58+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. Empty RNA sequence" equal? dna->rna '("") "")

    (test-success "2. RNA complement of cytosine is guanine" equal? dna->rna '("C") "G")

    (test-success "3. RNA complement of guanine is cytosine" equal? dna->rna '("G") "C")

    (test-success "4. RNA complement of thymine is adenine" equal? dna->rna '("T") "A")

    (test-success "5. RNA complement of adenine is uracil" equal? dna->rna '("A") "U")

    (test-success "6. RNA complement" equal? dna->rna '("ACGTGGTCTTAA") "UGCACCAGAAUU")
    ))

(run-with-cli "rna-transcription.scm" (list test-cases))
