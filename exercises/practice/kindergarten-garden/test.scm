; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/kindergarten-garden/canonical-data.json
; File last updated on 2026-10-13T05:07:29+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. garden with single student"
        equal? plants '("RC\nGG" "Alice")
        '("radishes" "clover" "grass" "grass"))
    (test-success "2. different garden with single student"
        equal? plants '("VC\nRC" "Alice")
        '("violets" "clover" "radishes" "clover"))
    (test-success "3. garden with two students"
        equal? plants '("VVCG\nVVRC" "Bob")
        '("clover" "grass" "radishes" "clover"))
    (test-success "4. second student's garden"
        equal? plants '("VVCCGG\nVVCCGG" "Bob")
        '("clover" "clover" "clover" "clover"))
    (test-success "5. third student's garden"
        equal? plants '("VVCCGG\nVVCCGG" "Charlie")
        '("grass" "grass" "grass" "grass"))
    (test-success "6. for Alice, first student's garden"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Alice")
        '("violets" "radishes" "violets" "radishes"))
    (test-success "7. for Bob, second student's garden"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Bob")
        '("clover" "grass" "clover" "clover"))
    (test-success "8. for Charlie"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Charlie")
        '("violets" "violets" "clover" "grass"))
    (test-success "9. for David"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "David")
        '("radishes" "violets" "clover" "radishes"))
    (test-success "10. for Eve"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Eve")
        '("clover" "grass" "radishes" "grass"))
    (test-success "11. for Fred"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Fred")
        '("grass" "clover" "violets" "clover"))
    (test-success "12. for Ginny"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Ginny")
        '("clover" "grass" "grass" "clover"))
    (test-success "13. for Harriet"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Harriet")
        '("violets" "radishes" "radishes" "violets"))
    (test-success "14. for Ileana"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Ileana")
        '("grass" "clover" "violets" "clover"))
    (test-success "15. for Joseph"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Joseph")
        '("violets" "clover" "violets" "grass"))
    (test-success "16. for Kincaid, second to last student's garden"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Kincaid")
        '("grass" "clover" "clover" "grass"))
    (test-success "17. for Larry, last student's garden"
        equal? plants '("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Larry")
        '("grass" "violets" "clover" "violets"))
    ))

(run-with-cli "kindergarten-garden.scm" (list test-cases))
