; These tests are auto-generated with test data from: 
; https://github.com/exercism/problem-specifications/blob/main/exercises/protein-translation/canonical-data.json
; File last updated on 2026-10-17T03:10:59+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. Empty RNA sequence results in no proteins"
        equal? proteins '("")
        '())
    (test-success "2. Methionine RNA sequence"
        equal? proteins '("AUG")
        '(methionine))
    (test-success "3. Phenylalanine RNA sequence 1"
        equal? proteins '("UUU")
        '(phenylalanine))
    (test-success "4. Phenylalanine RNA sequence 2"
        equal? proteins '("UUC")
        '(phenylalanine))
    (test-success "5. Leucine RNA sequence 1"
        equal? proteins '("UUA")
        '(leucine))
    (test-success "6. Leucine RNA sequence 2"
        equal? proteins '("UUG")
        '(leucine))
    (test-success "7. Serine RNA sequence 1"
        equal? proteins '("UCU")
        '(serine))
    (test-success "8. Serine RNA sequence 2"
        equal? proteins '("UCC")
        '(serine))
    (test-success "9. Serine RNA sequence 3"
        equal? proteins '("UCA")
        '(serine))
    (test-success "10. Serine RNA sequence 4"
        equal? proteins '("UCG")
        '(serine))
    (test-success "11. Tyrosine RNA sequence 1"
        equal? proteins '("UAU")
        '(tyrosine))
    (test-success "12. Tyrosine RNA sequence 2"
        equal? proteins '("UAC")
        '(tyrosine))
    (test-success "13. Cysteine RNA sequence 1"
        equal? proteins '("UGU")
        '(cysteine))
    (test-success "14. Cysteine RNA sequence 2"
        equal? proteins '("UGC")
        '(cysteine))
    (test-success "15. Tryptophan RNA sequence"
        equal? proteins '("UGG")
        '(tryptophan))
    (test-success "16. STOP codon RNA sequence 1"
        equal? proteins '("UAA")
        '())
    (test-success "17. STOP codon RNA sequence 2"
        equal? proteins '("UAG")
        '())
    (test-success "18. STOP codon RNA sequence 3"
        equal? proteins '("UGA")
        '())
    (test-success "19. Sequence of two protein codons translates into proteins"
        equal? proteins '("UUUUUU")
        '(phenylalanine phenylalanine))
    (test-success "20. Sequence of two different protein codons translates into proteins"
        equal? proteins '("UUAUUG")
        '(leucine leucine))
    (test-success "21. Translate RNA strand into correct protein list"
        equal? proteins '("AUGUUUUGG")
        '(methionine phenylalanine tryptophan))
    (test-success "22. Translation stops if STOP codon at beginning of sequence"
        equal? proteins '("UAGUGG")
        '())
    (test-success "23. Translation stops if STOP codon at end of two-codon sequence"
        equal? proteins '("UGGUAG")
        '(tryptophan))
    (test-success "24. Translation stops if STOP codon at end of three-codon sequence"
        equal? proteins '("AUGUUUUAA")
        '(methionine phenylalanine))
    (test-success "25. Translation stops if STOP codon in middle of three-codon sequence"
        equal? proteins '("UGGUAGUGG")
        '(tryptophan))
    (test-success "26. Translation stops if STOP codon in middle of six-codon sequence"
        equal? proteins '("UGGUGUUAUUAAUGGUUU")
        '(tryptophan cysteine tyrosine))
    (test-success "27. Sequence of two non-STOP codons does not translate to a STOP codon"
        equal? proteins '("AUGAUG")
        '(methionine methionine))
    (test-error "28. Unknown amino acids, not part of a codon, can't translate"
        proteins '("XYZ"))
    (test-error "29. Incomplete RNA sequence can't translate"
        proteins '("AUGU"))
    (test-success "30. Incomplete RNA sequence can translate if valid until a STOP codon"
        equal? proteins '("UUCUUCUAAUGGU")
        '(phenylalanine phenylalanine))
    ))

(run-with-cli "protein-translation.scm" (list test-cases))
