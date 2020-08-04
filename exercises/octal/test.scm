(load "octal.scm")

(use-modules (srfi srfi-64))

(test-begin "octal")

; (test-skip "octal 1 is decimal 1")
(test-eqv "octal 1 is decimal 1"
  (to-decimal "1")
  1)

(test-skip "octal 2 is decimal 2")
(test-eqv "octal 2 is decimal 2"
  (to-decimal "2")
  2)

(test-skip "octal 10 is decimal 8")
(test-eqv "octal 10 is decimal 8"
  (to-decimal "10")
  8)

(test-skip "octal 11 is decimal 9")
(test-eqv "octal 11 is decimal 9"
  (to-decimal "11")
  9)

(test-skip "octal 17 is deciaml 15")
(test-eqv "octal 17 is deciaml 15"
  (to-decimal "17")
  15)

(test-skip "octal 130 is decimal 88")
(test-eqv "octal 130 is decimal 88"
  (to-decimal "130")
  88)

(test-skip "octal 2047 is decimal 1063")
(test-eqv "octal 2047 is decimal 1063"
  (to-decimal "2047")
  1063)

(test-skip "octal 7777 is decimal 4095")
(test-eqv "octal 7777 is decimal 4095"
  (to-decimal "7777")
  4095)

(test-skip "octal 1234567 is decimal 342391")
(test-eqv "octal 1234567 is decimal 342391"
  (to-decimal "1234567")
  342391)

(test-skip "invalid input is decimal 0")
(test-eqv "invalid input is decimal 0"
  (to-decimal "carrot should be invalid")
  0)

(test-skip "8 is invalid octal")
(test-eqv "8 is invalid octal"
  (to-decimal "8")
  0)

(test-skip "9 is invalid octal")
(test-eqv "9 is invalid octal"
  (to-decimal "9")
  0)

(test-skip "6789 is invalid octal")
(test-eqv "6789 is invalid octal"
  (to-decimal "6789")
  0)

(test-skip "abc1z is invalid octal")
(test-eqv "abc1z is invalid octal"
  (to-decimal "abc1z")
  0)

(test-skip "leading zero is valid octal")
(test-eqv "leading zero is valid octal"
  (to-decimal "011")
  9)

(test-end "octal")
