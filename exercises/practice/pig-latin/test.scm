; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/pig-latin/canonical-data.json
; File last updated on 2026-10-17T09:48:14+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. word beginning with a"
        string=? translate '("apple") "appleay")
    (test-success "2. word beginning with e"
        string=? translate '("ear") "earay")
    (test-success "3. word beginning with i"
        string=? translate '("igloo") "iglooay")
    (test-success "4. word beginning with o"
        string=? translate '("object") "objectay")
    (test-success "5. word beginning with u"
        string=? translate '("under") "underay")
    (test-success "6. word beginning with a vowel and followed by a qu"
        string=? translate '("equal") "equalay")
    (test-success "7. word beginning with p"
        string=? translate '("pig") "igpay")
    (test-success "8. word beginning with k"
        string=? translate '("koala") "oalakay")
    (test-success "9. word beginning with x"
        string=? translate '("xenon") "enonxay")
    (test-success "10. word beginning with q without a following u"
        string=? translate '("qat") "atqay")
    (test-success "11. word beginning with consonant and vowel containing qu"
        string=? translate '("liquid") "iquidlay")
    (test-success "12. word beginning with ch"
        string=? translate '("chair") "airchay")
    (test-success "13. word beginning with qu"
        string=? translate '("queen") "eenquay")
    (test-success "14. word beginning with qu and a preceding consonant"
        string=? translate '("square") "aresquay")
    (test-success "15. word beginning with th"
        string=? translate '("therapy") "erapythay")
    (test-success "16. word beginning with thr"
        string=? translate '("thrush") "ushthray")
    (test-success "17. word beginning with sch"
        string=? translate '("school") "oolschay")
    (test-success "18. word beginning with yt"
        string=? translate '("yttria") "yttriaay")
    (test-success "19. word beginning with xr"
        string=? translate '("xray") "xrayay")
    (test-success "20. y is treated like a consonant at the beginning of a word"
        string=? translate '("yellow") "ellowyay")
    (test-success "21. y is treated like a vowel at the end of a consonant cluster"
        string=? translate '("rhythm") "ythmrhay")
    (test-success "22. y as second letter in two letter word"
        string=? translate '("my") "ymay")
    (test-success "23. a whole phrase"
        string=? translate '("quick fast run") "ickquay astfay unray")
    ))

(run-with-cli "pig-latin.scm" (list test-cases))
