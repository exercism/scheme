(load "test-util.ss")

(define test-cases
  `((test-success "octal 1 is decimal 1" equal? to-decimal
      '("1") 1)
     (test-success "octal 2 is decimal 2" equal? to-decimal
       '("2") 2)
     (test-success "octal 10 is decimal 8" equal? to-decimal
       '("10") 8)
     (test-success "octal 11 is decimal 9" equal? to-decimal
       '("11") 9)
     (test-success "octal 17 is deciaml 15" equal? to-decimal
       '("17") 15)
     (test-success "octal 130 is decimal 88" equal? to-decimal
       '("130") 88)
     (test-success "octal 2047 is decimal 1063" equal? to-decimal
       '("2047") 1063)
     (test-success "octal 7777 is decimal 4095" equal? to-decimal
       '("7777") 4095)
     (test-success "octal 1234567 is decimal 342391" equal?
       to-decimal '("1234567") 342391)
     (test-success "invalid input is decimal 0" equal? to-decimal
       '("carrot should be invalid") 0)
     (test-success "8 is invalid octal" equal? to-decimal '("8")
       0)
     (test-success "9 is invalid octal" equal? to-decimal '("9")
       0)
     (test-success "6789 is invalid octal" equal? to-decimal
       '("6789") 0)
     (test-success "abc1z is invalid octal" equal? to-decimal
       '("abc1z") 0)
     (test-success "leading zero is valid octal" equal?
       to-decimal '("011") 9)))

(run-with-cli "octal.scm" (list test-cases))

