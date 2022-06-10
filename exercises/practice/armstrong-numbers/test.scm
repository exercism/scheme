(load "test-util.ss")

(define test-cases
  `((test-success "Zero is an Armstrong number" equal?
      armstrong-number? '(0) #t)
    (test-success "Single digit numbers are Armstrong numbers"
      equal? armstrong-number? '(5) #t)
    (test-success "There are no 2 digit Armstrong numbers"
      equal? armstrong-number? '(10) #f)
    (test-success
      "Three digit number that is an Armstrong number" equal?
      armstrong-number? '(153) #t)
    (test-success
      "Three digit number that is not an Armstrong number" equal?
      armstrong-number? '(100) #f)
    (test-success
      "Four digit number that is an Armstrong number" equal?
      armstrong-number? '(9474) #t)
    (test-success
      "Four digit number that is not an Armstrong number" equal?
      armstrong-number? '(9475) #f)
    (test-success
      "Seven digit number that is an Armstrong number" equal?
      armstrong-number? '(9926315) #t)
    (test-success
      "Seven digit number that is not an Armstrong number" equal?
      armstrong-number? '(9926314) #f)
    (test-success "The 25th Armstrong number" equal?
      armstrong-number? '(24678050) #t)
    (test-success
      "Eight digit number that is not an Armstrong number" equal?
      armstrong-number? '(30852815) #f)
    (test-success "The 28th Armstrong number" equal?
      armstrong-number? '(146511208) #t)
    (test-success
      "Nine digit number that is not an Armstrong number" equal?
      armstrong-number? '(927427554) #f)
    (test-success "The 32nd Armstrong number" equal?
      armstrong-number? '(4679307774) #t)
    (test-success
      "Ten digit number that is not an Armstrong number" equal?
      armstrong-number? '(8320172640) #f)
    (test-success "The 34th Armstrong number" equal?
      armstrong-number? '(32164049651) #t)
    (test-success
      "Eleven digit number that is not an Armstrong number" equal?
      armstrong-number? '(13930642218) #f)
    (test-success "The 66th Armstrong number" equal?
      armstrong-number? '(4422095118095899619457938) #t)
    (test-success "The 77th Armstrong number" equal?
      armstrong-number? '(1927890457142960697580636236639) #t)
    (test-success "The 88th Armstrong number" equal?
      armstrong-number? '(115132219018763992565095597973971522401)
      #t)
    (test-success "Thirty-nine digit number that is not an Armstrong number"
      equal? armstrong-number?
      '(7744959048678381442547644364350528967165) #f)))

(run-with-cli "armstrong-numbers.scm" (list test-cases))

