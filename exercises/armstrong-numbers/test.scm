(load "armstrong-numbers.scm")

(use-modules (srfi srfi-64))

(test-begin "armstrong-numbers")

(test-eq "Zero is an Armstrong number"
  (armstrong-number? 0)
  #t)

(test-eq "Single digit numbers are Armstrong numbers"
  (armstrong-number? 5)
  #t)

(test-eq "There are no 2 digit Armstrong numbers"
  (armstrong-number? 10)
  #f)

(test-eq "Three digit number that is an Armstrong number"
  (armstrong-number? 153)
  #t)

(test-eq "Three digit number that is not an Armstrong number"
  (armstrong-number? 100)
  #f)

(test-eq "Four digit number that is an Armstrong number"
  (armstrong-number? 9474)
  #t)

(test-eq "Four digit number that is not an Armstrong number"
  (armstrong-number? 9475)
  #f)

(test-eq "Seven digit number that is an Armstrong number"
  (armstrong-number? 9926315)
  #t)

(test-eq "Seven digit number that is not an Armstrong number"
  (armstrong-number? 9926314)
  #f)

(test-eq "The 25th Armstrong number"
  (armstrong-number? 24678050)
  #t)

(test-eq "Eight digit number that is not an Armstrong number"
  (armstrong-number? 30852815)
  #f)

(test-eq "The 28th Armstrong number"
  (armstrong-number? 146511208)
  #t)

(test-eq "Nine digit number that is not an Armstrong number"
  (armstrong-number? 927427554)
  #f)

(test-eq "The 32nd Armstrong number"
  (armstrong-number? 4679307774)
  #t)

(test-eq "Ten digit number that is not an Armstrong number"
  (armstrong-number? 8320172640)
  #f)

(test-eq "The 34th Armstrong number"
  (armstrong-number? 32164049651)
  #t)

(test-eq "Eleven digit number that is not an Armstrong number"
  (armstrong-number? 13930642218)
  #f)

(test-eq "The 66th Armstrong number"
  (armstrong-number? 4422095118095899619457938)
  #t)

(test-eq "The 77th Armstrong number"
  (armstrong-number? 1927890457142960697580636236639)
  #t)

(test-eq "The 88th Armstrong number"
  (armstrong-number? 115132219018763992565095597973971522401)
  #t)

(test-eq "Thirty-nine digit number that is not an Armstrong number"
  (armstrong-number? 7744959048678381442547644364350528967165)
  #f)

(test-end "armstrong-numbers")
