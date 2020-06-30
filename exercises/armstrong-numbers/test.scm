(load "armstrong-numbers.scm")

(use-modules (srfi srfi-64))

(test-begin "armstrong-numbers")

; (test-skip "Zero is an Armstrong number")
(test-assert "Zero is an Armstrong number"
  (armstrong-number? 0))

(test-skip "Single digit numbers are Armstrong numbers")
(test-assert "Single digit numbers are Armstrong numbers"
  (armstrong-number? 5))

(test-skip "There are no 2 digit Armstrong numbers")
(test-assert "There are no 2 digit Armstrong numbers"
  (not (armstrong-number? 10)))

(test-skip "Three digit number that is an Armstrong number")
(test-assert "Three digit number that is an Armstrong number"
  (armstrong-number? 153))

(test-skip "Three digit number that is not an Armstrong number")
(test-assert "Three digit number that is not an Armstrong number"
  (not (armstrong-number? 100)))

(test-skip "Four digit number that is an Armstrong number")
(test-assert "Four digit number that is an Armstrong number"
  (armstrong-number? 9474))

(test-skip "Four digit number that is not an Armstrong number")
(test-assert "Four digit number that is not an Armstrong number"
  (not (armstrong-number? 9475)))

(test-skip "Seven digit number that is an Armstrong number")
(test-assert "Seven digit number that is an Armstrong number"
  (armstrong-number? 9926315))

(test-skip "Seven digit number that is not an Armstrong number")
(test-assert "Seven digit number that is not an Armstrong number"
  (not (armstrong-number? 9926314)))

(test-skip "The 25th Armstrong number")
(test-assert "The 25th Armstrong number"
  (armstrong-number? 24678050))

(test-skip "Eight digit number that is not an Armstrong number")
(test-assert "Eight digit number that is not an Armstrong number"
  (not (armstrong-number? 30852815)))

(test-skip "The 28th Armstrong number")
(test-assert "The 28th Armstrong number"
  (armstrong-number? 146511208))

(test-skip "Nine digit number that is not an Armstrong number")
(test-assert "Nine digit number that is not an Armstrong number"
  (not (armstrong-number? 927427554)))

(test-skip "The 32nd Armstrong number")
(test-assert "The 32nd Armstrong number"
  (armstrong-number? 4679307774))

(test-skip "Ten digit number that is not an Armstrong number")
(test-assert "Ten digit number that is not an Armstrong number"
  (not (armstrong-number? 8320172640)))

(test-skip "The 34th Armstrong number")
(test-assert "The 34th Armstrong number"
  (armstrong-number? 32164049651))

(test-skip "Eleven digit number that is not an Armstrong number")
(test-assert "Eleven digit number that is not an Armstrong number"
  (not (armstrong-number? 13930642218)))

(test-skip "The 66th Armstrong number")
(test-assert "The 66th Armstrong number"
  (armstrong-number? 4422095118095899619457938))

(test-skip "The 77th Armstrong number")
(test-assert "The 77th Armstrong number"
  (armstrong-number? 1927890457142960697580636236639))

(test-skip "The 88th Armstrong number")
(test-assert "The 88th Armstrong number"
  (armstrong-number? 115132219018763992565095597973971522401))

(test-skip "Thirty-nine digit number that is not an Armstrong number")
(test-assert "Thirty-nine digit number that is not an Armstrong number"
  (not (armstrong-number? 7744959048678381442547644364350528967165)))

(test-end "armstrong-numbers")
