; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/variable-length-quantity/canonical-data.json
; File last updated on 2026-10-17T10:00:34+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. encode - zero"
        equal? encode '((0))
        '(0))
    (test-success "2. encode - arbitrary single byte"
        equal? encode '((64))
        '(64))
    (test-success "3. encode - asymmetric single byte"
        equal? encode '((83))
        '(83))
    (test-success "4. encode - largest single byte"
        equal? encode '((127))
        '(127))
    (test-success "5. encode - smallest double byte"
        equal? encode '((128))
        '(129 0))
    (test-success "6. encode - arbitrary double byte"
        equal? encode '((8192))
        '(192 0))
    (test-success "7. encode - asymmetric double byte"
        equal? encode '((173))
        '(129 45))
    (test-success "8. encode - largest double byte"
        equal? encode '((16383))
        '(255 127))
    (test-success "9. encode - smallest triple byte"
        equal? encode '((16384))
        '(129 128 0))
    (test-success "10. encode - arbitrary triple byte"
        equal? encode '((1048576))
        '(192 128 0))
    (test-success "11. encode - asymmetric triple byte"
        equal? encode '((120220))
        '(135 171 28))
    (test-success "12. encode - largest triple byte"
        equal? encode '((2097151))
        '(255 255 127))
    (test-success "13. encode - smallest quadruple byte"
        equal? encode '((2097152))
        '(129 128 128 0))
    (test-success "14. encode - arbitrary quadruple byte"
        equal? encode '((134217728))
        '(192 128 128 0))
    (test-success "15. encode - asymmetric quadruple byte"
        equal? encode '((3503876))
        '(129 213 238 4))
    (test-success "16. encode - largest quadruple byte"
        equal? encode '((268435455))
        '(255 255 255 127))
    (test-success "17. encode - smallest quintuple byte"
        equal? encode '((268435456))
        '(129 128 128 128 0))
    (test-success "18. encode - arbitrary quintuple byte"
        equal? encode '((4278190080))
        '(143 248 128 128 0))
    (test-success "19. encode - asymmetric quintuple byte"
        equal? encode '((2254790917))
        '(136 179 149 194 5))
    (test-success "20. encode - maximum 32-bit integer input"
        equal? encode '((4294967295))
        '(143 255 255 255 127))
    (test-success "21. encode - two single-byte values"
        equal? encode '((64 127))
        '(64 127))
    (test-success "22. encode - two multi-byte values"
        equal? encode '((16384 1193046))
        '(129 128 0 200 232 86))
    (test-success "23. encode - many multi-byte values"
        equal? encode '((8192 1193046 268435455 0 16383 16384))
        '(192 0 200 232 86 255 255 255 127 0 255 127 129 128 0))
    (test-success "24. decode - one byte"
        equal? decode '((127))
        '(127))
    (test-success "25. decode - two bytes"
        equal? decode '((192 0))
        '(8192))
    (test-success "26. decode - three bytes"
        equal? decode '((255 255 127))
        '(2097151))
    (test-success "27. decode - four bytes"
        equal? decode '((129 128 128 0))
        '(2097152))
    (test-success "28. decode - maximum 32-bit integer"
        equal? decode '((143 255 255 255 127))
        '(4294967295))
    (test-error "29. decode - incomplete sequence causes error"
        decode '((255)))
    (test-error "30. decode - incomplete sequence causes error, even if value is zero"
        decode '((128)))
    (test-success "31. decode - multiple values"
        equal? decode '((192 0 200 232 86 255 255 255 127 0 255 127 129 128 0))
        '(8192 1193046 268435455 0 16383 16384))
    ))

(run-with-cli "variable-length-quantity.scm" (list test-cases))
