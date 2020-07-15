(load "roman-numerals.scm")

(use-modules (srfi srfi-64))

(test-begin "roman-numerals")

; (test-skip "1 is a single I")
(test-equal "1 is a single I"
  (roman 1)
  "I")

(test-skip "2 is two I's")
(test-equal "2 is two I's"
  (roman 2)
  "II")

(test-skip "3 is three I's")
(test-equal "3 is three I's"
  (roman 3)
  "III")

(test-skip "4, being 5 - 1, is IV")
(test-equal "4, being 5 - 1, is IV"
  (roman 4)
  "IV")

(test-skip "5 is a single V")
(test-equal "5 is a single V"
  (roman 5)
  "V")

(test-skip "6, being 5 + 1, is VI")
(test-equal "6, being 5 + 1, is VI"
  (roman 6)
  "VI")

(test-skip "9, being 10 - 1, is IX")
(test-equal "9, being 10 - 1, is IX"
  (roman 9)
  "IX")

(test-skip "20 is two X's")
(test-equal "20 is two X's"
  (roman 20)
  "XX")

(test-skip "27 is 10 + 10 + 5 + 1 + 1")
(test-equal "27 is 10 + 10 + 5 + 1 + 1"
  (roman 27)
  "XXVII")

(test-skip "48 is not 50 - 2 but rather 40 + 8")
(test-equal "48 is not 50 - 2 but rather 40 + 8"
  (roman 48)
  "XLVIII")

(test-skip "49 is not 40 + 5 + 4 but rather 50 - 10 + 10 - 1")
(test-equal "49 is not 40 + 5 + 4 but rather 50 - 10 + 10 - 1"
  (roman 49)
  "XLIX")

(test-skip "50 is a single L")
(test-equal "50 is a single L"
  (roman 50)
  "L")

(test-skip "59 is 50 + 10 - 1")
(test-equal "59 is 50 + 10 - 1"
  (roman 59)
  "LIX")

(test-skip "60, being 50 + 10, is LX")
(test-equal "60, being 50 + 10, is LX"
  (roman 60)
  "LX")

(test-skip "90, being 100 - 10, is XC")
(test-equal "90, being 100 - 10, is XC"
  (roman 90)
  "XC")

(test-skip "93 is 100 - 10 + 1 + 1 + 1")
(test-equal "93 is 100 - 10 + 1 + 1 + 1"
  (roman 93)
  "XCIII")

(test-skip "100 is a single C")
(test-equal "100 is a single C"
  (roman 100)
  "C")

(test-skip "141 is 100 + 50 - 10 + 1")
(test-equal "141 is 100 + 50 - 10 + 1"
  (roman 141)
  "CXLI")

(test-skip "163 is 100 + 50 + 10 + 1 + 1 + 1")
(test-equal "163 is 100 + 50 + 10 + 1 + 1 + 1"
  (roman 163)
  "CLXIII")

(test-skip "400, being 500 - 100, is CD")
(test-equal "400, being 500 - 100, is CD"
  (roman 400)
  "CD")

(test-skip "402 is 500 - 100 + 2")
(test-equal "402 is 500 - 100 + 2"
  (roman 402)
  "CDII")

(test-skip "500 is a single D")
(test-equal "500 is a single D"
  (roman 500)
  "D")

(test-skip "575 is 500 + 50 + 10 + 10 + 5")
(test-equal "575 is 500 + 50 + 10 + 10 + 5"
  (roman 575)
  "DLXXV")

(test-skip "900, being 1000 - 100, is CM")
(test-equal "900, being 1000 - 100, is CM"
  (roman 900)
  "CM")

(test-skip "911 is 1000 - 100 + 10 + 1")
(test-equal "911 is 1000 - 100 + 10 + 1"
  (roman 911)
  "CMXI")

(test-skip "1000 is a single M")
(test-equal "1000 is a single M"
  (roman 1000)
  "M")

(test-skip "1024 is 1000 + 10 + 10 + 5 - 1")
(test-equal "1024 is 1000 + 10 + 10 + 5 - 1"
  (roman 1024)
  "MXXIV")

(test-skip "3000 is three M's")
(test-equal "3000 is three M's"
  (roman 3000)
  "MMM")

(test-end "roman-numerals")
