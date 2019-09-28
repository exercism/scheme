(unless (assoc "code" (library-directories))
  (library-directories (cons "code" (library-directories))))

(import (json)
	(sxml))

(define source-files
  '("code/outils.ss"
    "code/config.ss"
    "code/test.ss"
    "code/md.ss"
    "code/track.ss"))

(define implementations
  '(
    hello-world
    ;;    leap
    ;;    rna-transcription
    ;;    hamming
    ;;    grains
    ;;    anagram
    ;;    nucleotide-count
    ;;    atbash-cipher
    pascals-triangle
    ;;    sieve
    ;;    change
    ;;    knapsack
    ;;    sublist
    ))

(for-each load source-files)
;; (for-each load-problem implementations)
