(unless (assoc "code" (library-directories))
  (library-directories (cons "code" (library-directories))))

(import (json))

(define (load-problem problem)
  (load (format "code/exercises/~a/~a.ss" problem problem)))

(define source-files
  '("code/outils.ss"
    "code/config.ss"
    "code/test.ss"
    "code/track.ss"))

(define implementations
  '(hello-world
    leap
    rna-transcription
    hamming
    grains
    anagram
    nucleotide-count
    atbash-cipher
    pascals-triangle
    sieve
;;    sublist
    ))

(for-each load source-files)
(for-each load-problem implementations)





