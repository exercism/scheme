(load "test-util.ss")

(define test-cases
  `((test-success "1 is a single I" equal? roman '(1) "I")
    (test-success "2 is two I's" equal? roman '(2) "II")
    (test-success "3 is three I's" equal? roman '(3) "III")
    (test-success "4, being 5 - 1, is IV" equal? roman '(4)
      "IV")
    (test-success "5 is a single V" equal? roman '(5) "V")
    (test-success "6, being 5 + 1, is VI" equal? roman '(6)
      "VI")
    (test-success "9, being 10 - 1, is IX" equal? roman '(9)
      "IX")
    (test-success "20 is two X's" equal? roman '(20) "XX")
    (test-success "27 is 10 + 10 + 5 + 1 + 1" equal? roman '(27)
      "XXVII")
    (test-success "48 is not 50 - 2 but rather 40 + 8" equal?
      roman '(48) "XLVIII")
    (test-success
      "49 is not 40 + 5 + 4 but rather 50 - 10 + 10 - 1" equal?
      roman '(49) "XLIX")
    (test-success "50 is a single L" equal? roman '(50) "L")
    (test-success "59 is 50 + 10 - 1" equal? roman '(59) "LIX")
    (test-success "60, being 50 + 10, is LX" equal? roman '(60)
      "LX")
    (test-success "90, being 100 - 10, is XC" equal? roman '(90)
      "XC")
    (test-success "93 is 100 - 10 + 1 + 1 + 1" equal? roman
      '(93) "XCIII")
    (test-success "100 is a single C" equal? roman '(100) "C")
    (test-success "141 is 100 + 50 - 10 + 1" equal? roman '(141)
      "CXLI")
    (test-success "163 is 100 + 50 + 10 + 1 + 1 + 1" equal?
      roman '(163) "CLXIII")
    (test-success "400, being 500 - 100, is CD" equal? roman
      '(400) "CD")
    (test-success "402 is 500 - 100 + 2" equal? roman '(402)
      "CDII")
    (test-success "500 is a single D" equal? roman '(500) "D")
    (test-success "575 is 500 + 50 + 10 + 10 + 5" equal? roman
      '(575) "DLXXV")
    (test-success "900, being 1000 - 100, is CM" equal? roman
      '(900) "CM")
    (test-success "911 is 1000 - 100 + 10 + 1" equal? roman
      '(911) "CMXI")
    (test-success "1000 is a single M" equal? roman '(1000) "M")
    (test-success "1024 is 1000 + 10 + 10 + 5 - 1" equal? roman
      '(1024) "MXXIV")
    (test-success "3000 is three M's" equal? roman '(3000)
      "MMM")))

(run-with-cli "roman-numerals.scm" (list test-cases))

