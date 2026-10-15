; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/intergalactic-transmission/canonical-data.json
; File last updated on 2026-10-18T10:12:19+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. calculate transmit sequences - empty message"
        equal? transmit-sequence '(())
        '())
    (test-success "2. calculate transmit sequences - 0x00 is transmitted as 0x0000"
        equal? transmit-sequence '((#x00))
        '(#x00 #x00))
    (test-success "3. calculate transmit sequences - 0x02 is transmitted as 0x0300"
        equal? transmit-sequence '((#x02))
        '(#x03 #x00))
    (test-success "4. calculate transmit sequences - 0x06 is transmitted as 0x0600"
        equal? transmit-sequence '((#x06))
        '(#x06 #x00))
    (test-success "5. calculate transmit sequences - 0x05 is transmitted as 0x0581"
        equal? transmit-sequence '((#x05))
        '(#x05 #x81))
    (test-success "6. calculate transmit sequences - 0x29 is transmitted as 0x2881"
        equal? transmit-sequence '((#x29))
        '(#x28 #x81))
    (test-success "7. calculate transmit sequences - 0xc001c0de is transmitted as 0xc000711be1"
        equal? transmit-sequence '((#xc0 #x01 #xc0 #xde))
        '(#xc0 #x00 #x71 #x1b #xe1))
    (test-success "8. calculate transmit sequences - six byte message"
        equal? transmit-sequence '((#x47 #x72 #x65 #x61 #x74 #x21))
        '(#x47 #xb8 #x99 #xac #x17 #xa0 #x84))
    (test-success "9. calculate transmit sequences - seven byte message"
        equal? transmit-sequence '((#x47 #x72 #x65 #x61 #x74 #x31 #x21))
        '(#x47 #xb8 #x99 #xac #x17 #xa0 #xc5 #x42))
    (test-success "10. calculate transmit sequences - eight byte message"
        equal? transmit-sequence '((#xc0 #x01 #x13 #x37 #xc0 #xde #x21 #x21))
        '(#xc0 #x00 #x44 #x66 #x7d #x06 #x78 #x42 #x21 #x81))
    (test-success "11. calculate transmit sequences - twenty byte message"
        equal? transmit-sequence '((#x45 #x78 #x65 #x72 #x63 #x69 #x73 #x6d #x20 #x69 #x73 #x20 #x61 #x77 #x65 #x73 #x6f #x6d #x65 #x21))
        '(#x44 #xbd #x18 #xaf #x27 #x1b #xa5 #xe7 #x6c #x90 #x1b #x2e #x33 #x03 #x84 #xee #x65 #xb8 #xdb #xed #xd7 #x28 #x84))
    (test-success "12. decode received messages - empty message"
        equal? decode-message '(())
        '())
    (test-success "13. decode received messages - zero message"
        equal? decode-message '((#x00 #x00))
        '(#x00))
    (test-success "14. decode received messages - 0x0300 is decoded to 0x02"
        equal? decode-message '((#x03 #x00))
        '(#x02))
    (test-success "15. decode received messages - 0x0581 is decoded to 0x05"
        equal? decode-message '((#x05 #x81))
        '(#x05))
    (test-success "16. decode received messages - 0x2881 is decoded to 0x29"
        equal? decode-message '((#x28 #x81))
        '(#x29))
    (test-error "17. decode received messages - first byte has wrong parity"
        decode-message '((#x07 #x00)))
    (test-error "18. decode received messages - second byte has wrong parity"
        decode-message '((#x03 #x68)))
    (test-success "19. decode received messages - 0xcf4b00 is decoded to 0xce94"
        equal? decode-message '((#xcf #x4b #x00))
        '(#xce #x94))
    (test-success "20. decode received messages - 0xe2566500 is decoded to 0xe2ad90"
        equal? decode-message '((#xe2 #x56 #x65 #x00))
        '(#xe2 #xad #x90))
    (test-success "21. decode received messages - six byte message"
        equal? decode-message '((#x47 #xb8 #x99 #xac #x17 #xa0 #x84))
        '(#x47 #x72 #x65 #x61 #x74 #x21))
    (test-success "22. decode received messages - seven byte message"
        equal? decode-message '((#x47 #xb8 #x99 #xac #x17 #xa0 #xc5 #x42))
        '(#x47 #x72 #x65 #x61 #x74 #x31 #x21))
    (test-error "23. decode received messages - last byte has wrong parity"
        decode-message '((#x47 #xb8 #x99 #xac #x17 #xa0 #xc5 #x43)))
    (test-success "24. decode received messages - eight byte message"
        equal? decode-message '((#xc0 #x00 #x44 #x66 #x7d #x06 #x78 #x42 #x21 #x81))
        '(#xc0 #x01 #x13 #x37 #xc0 #xde #x21 #x21))
    (test-success "25. decode received messages - twenty byte message"
        equal? decode-message '((#x44 #xbd #x18 #xaf #x27 #x1b #xa5 #xe7 #x6c #x90 #x1b #x2e #x33 #x03 #x84 #xee #x65 #xb8 #xdb #xed #xd7 #x28 #x84))
        '(#x45 #x78 #x65 #x72 #x63 #x69 #x73 #x6d #x20 #x69 #x73 #x20 #x61 #x77 #x65 #x73 #x6f #x6d #x65 #x21))
    (test-error "26. decode received messages - wrong parity on 16th byte"
        decode-message '((#x44 #xbd #x18 #xaf #x27 #x1b #xa5 #xe7 #x6c #x90 #x1b #x2e #x33 #x03 #x84 #xef #x65 #xb8 #xdb #xed #xd7 #x28 #x84)))
    ))

(run-with-cli "intergalactic-transmission.scm" (list test-cases))
