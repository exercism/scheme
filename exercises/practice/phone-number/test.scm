(load "test-util.ss")

(define test-cases
  `((test-success "cleans the number" equal? clean
      '("(223) 456-7890") "2234567890")
     (test-success "cleans numbers with dots" equal? clean
       '("223.456.7890") "2234567890")
     (test-success "cleans numbers with multiple spaces" equal?
       clean '("223 456   7890   ") "2234567890")
     (test-error "invalid when 9 digits" clean '("123456789"))
     (test-error
       "invalid when 11 digits does not start with a 1"
       clean
       '("22234567890"))
     (test-success "valid when 11 digits and starting with 1"
       equal? clean '("12234567890") "2234567890")
     (test-success
       "valid when 11 digits and starting with 1 even with punctuation"
       equal? clean '("+1 (223) 456-7890") "2234567890")
     (test-error
       "invalid when more than 11 digits"
       clean
       '("321234567890"))
     (test-error "invalid with letters" clean '("123-abc-7890"))
     (test-error
       "invalid with punctuations"
       clean
       '("123-@:!-7890"))
     (test-error
       "invalid if area code starts with 0"
       clean
       '("(023) 456-7890"))
     (test-error
       "invalid if area code starts with 1"
       clean
       '("(123) 456-7890"))
     (test-error
       "invalid if exchange code starts with 0"
       clean
       '("(223) 056-7890"))
     (test-error
       "invalid if exchange code starts with 1"
       clean
       '("(223) 156-7890"))
     (test-error
       "invalid if area code starts with 0 on valid 11-digit number"
       clean
       '("1 (023) 456-7890"))
     (test-error
       "invalid if area code starts with 1 on valid 11-digit number"
       clean
       '("1 (123) 456-7890"))
     (test-error
       "invalid if exchange code starts with 0 on valid 11-digit number"
       clean
       '("1 (223) 056-7890"))
     (test-error
       "invalid if exchange code starts with 1 on valid 11-digit number"
       clean
       '("1 (223) 156-7890"))))

(run-with-cli "phone-number.scm" (list test-cases))

