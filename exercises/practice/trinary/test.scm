(load "test-util.ss")

(define test-cases
  `((test-success
      "returns the decimal representation of the input trinary value"
      equal? to-decimal '("1") 1)
     (test-success "trinary 2 is decimal 2" equal? to-decimal
       '("2") 2)
     (test-success "trinary 10 is decimal 3" equal? to-decimal
       '("10") 3)
     (test-success "trinary 11 is decimal 4" equal? to-decimal
       '("11") 4)
     (test-success "trinary 100 is decimal 9" equal? to-decimal
       '("100") 9)
     (test-success "trinary 112 is decimal 14" equal? to-decimal
       '("112") 14)
     (test-success "trinary 222 is decimal 26" equal? to-decimal
       '("222") 26)
     (test-success "trinary 1122000120 is decimal 32091" equal?
       to-decimal '("1122000120") 32091)
     (test-success "invalid trinary digits returns 0" equal?
       to-decimal '("1234") 0)
     (test-success "invalid word as input returns 0" equal?
       to-decimal '("carrot") 0)
     (test-success
       "invalid numbers with letters as input returns 0" equal?
       to-decimal '("0a1b2c") 0)))

(run-with-cli "trinary.scm" (list test-cases))

