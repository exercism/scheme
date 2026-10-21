; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/nucleotide-count/canonical-data.json
; File last updated on 2026-10-21T17:10:38+00:00

(load "test-util.ss")

; Compare nucleotide counts ignoring order and zero counts.
(define (counts-equal? xs ys)
  (let ([normalize (lambda (counts)
                     (list-sort (lambda (a b) (char<? (car a) (car b)))
                                (filter (lambda (x) (not (zero? (cdr x)))) counts)))])
    (equal? (normalize xs) (normalize ys))))

(define test-cases
  `(
    (test-success "1. empty strand" counts-equal? nucleotide-count '("")
        '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0)))

    (test-success "2. can count one nucleotide in single-character input" counts-equal? nucleotide-count '("G")
        '((#\A . 0) (#\C . 0) (#\G . 1) (#\T . 0)))

    (test-success "3. strand with repeated nucleotide" counts-equal? nucleotide-count '("GGGGGGG")
        '((#\A . 0) (#\C . 0) (#\G . 7) (#\T . 0)))

    (test-success "4. strand with multiple nucleotides" counts-equal? nucleotide-count '("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
        '((#\A . 20) (#\C . 12) (#\G . 17) (#\T . 21)))

    (test-error "5. strand with invalid nucleotides" nucleotide-count '("AGXXACT"))
    ))

(run-with-cli "nucleotide-count.scm" (list test-cases))
