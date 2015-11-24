### Running tests

Run `guile test-file.scm` from the command line.

### Making your first Scheme solution

To create scheme code that can be loaded with `(use-modules (dna))`,
put this code in `dna.scm`:

```scheme
(define-module (dna)
  #:export (to-rna))

(define to-rna
  (lambda (dna)
  ;; Do something to transcribe dna to rna
  ))
```
