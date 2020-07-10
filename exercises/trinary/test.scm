(load "trinary.scm")

(use-modules (srfi srfi-64))

(test-begin "trinary")

; (test-skip "returns the decimal representation of the input trinary value")
(test-eqv "returns the decimal representation of the input trinary value"
  (to-decimal "1")
  1)

(test-skip "trinary 2 is decimal 2")
(test-eqv "trinary 2 is decimal 2"
  (to-decimal "2")
  2)

(test-skip "trinary 10 is decimal 3")
(test-eqv "trinary 10 is decimal 3"
  (to-decimal "10")
  3)

(test-skip "trinary 11 is decimal 4")
(test-eqv "trinary 11 is decimal 4"
  (to-decimal "11")
  4)

(test-skip "trinary 100 is decimal 9")
(test-eqv "trinary 100 is decimal 9"
  (to-decimal "100")
  9)

(test-skip "trinary 112 is decimal 14")
(test-eqv "trinary 112 is decimal 14"
  (to-decimal "112")
  14)

(test-skip "trinary 222 is decimal 26")
(test-eqv "trinary 222 is decimal 26"
  (to-decimal "222")
  26)

(test-skip "trinary 1122000120 is decimal 32091")
(test-eqv "trinary 1122000120 is decimal 32091"
  (to-decimal "1122000120")
  32091)

(test-skip "invalid trinary digits returns 0")
(test-eqv "invalid trinary digits returns 0"
  (to-decimal "1234")
  0)

(test-skip "invalid word as input returns 0")
(test-eqv "invalid word as input returns 0"
  (to-decimal "carrot")
  0)

(test-skip "invalid numbers with letters as input returns 0")
(test-eqv "invalid numbers with letters as input returns 0"
  (to-decimal "0a1b2c")
  0)

(test-end "trinary")
