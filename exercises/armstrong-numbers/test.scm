(load "armstrong-numbers.scm")

(use-modules (srfi srfi-64))

(test-begin "armstrong-numbers")

(test-assert "Zero is an Armstrong number"
  (armstrong-number? 0))

(test-assert "Single digit numbers are Armstrong numbers"
  (armstrong-number? 5))

(test-assert "There are no 2 digit Armstrong numbers"
  (not (armstrong-number? 10)))

(test-assert "Three digit number that is an Armstrong number"
  (armstrong-number? 153))

(test-assert "Three digit number that is not an Armstrong number"
  (not (armstrong-number? 100)))

(test-assert "Four digit number that is an Armstrong number"
  (armstrong-number? 9474))

(test-assert "Four digit number that is not an Armstrong number"
  (not (armstrong-number? 9475)))

(test-assert "Seven digit number that is an Armstrong number"
  (armstrong-number? 9926315))

(test-assert "Seven digit number that is not an Armstrong number"
  (not (armstrong-number? 9926314)))

(test-assert "The 25th Armstrong number"
  (armstrong-number? 24678050))

(test-assert "Eight digit number that is not an Armstrong number"
  (not (armstrong-number? 30852815)))

(test-assert "The 28th Armstrong number"
  (armstrong-number? 146511208))

(test-assert "Nine digit number that is not an Armstrong number"
  (not (armstrong-number? 927427554)))

(test-assert "The 32nd Armstrong number"
  (armstrong-number? 4679307774))

(test-assert "Ten digit number that is not an Armstrong number"
  (not (armstrong-number? 8320172640)))

(test-assert "The 34th Armstrong number"
  (armstrong-number? 32164049651))

(test-assert "Eleven digit number that is not an Armstrong number"
  (not (armstrong-number? 13930642218)))

(test-assert "The 66th Armstrong number"
  (armstrong-number? 4422095118095899619457938))

(test-assert "The 77th Armstrong number"
  (armstrong-number? 1927890457142960697580636236639))

(test-assert "The 88th Armstrong number"
  (armstrong-number? 115132219018763992565095597973971522401))

(test-assert "Thirty-nine digit number that is not an Armstrong number"
  (not (armstrong-number? 7744959048678381442547644364350528967165)))

(test-end "armstrong-numbers")
