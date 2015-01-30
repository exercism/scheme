(use-modules (srfi srfi-64))

(add-to-load-path (dirname (current-filename)))
(use-modules (dna))

(test-begin "rna-transcription")

(test-equal "transcribes-cytosine-to-guanine"
          "G"
          (to-rna "C"))

(test-equal "transcribes-guanine-to-cytosine"
          "C"
          (to-rna "G"))

(test-equal "transcribes-adenine-to-uracil"
          "U"
          (to-rna "A"))

(test-equal "transcribes-thymine-to-adenine"
          "A"
          (to-rna "T"))

(test-equal "transcribes-all-nucleotides"
          "UGCACCAGAAUU"
          (to-rna "ACGTGGTCTTAA"))


(test-error "it-validates-dna-strands"
            #t
            (to-rna "XCGFGGTDTTAA"))

(test-end "rna-transcription")
