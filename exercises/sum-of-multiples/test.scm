(load "sum-of-multiples.scm")

(use-modules (srfi srfi-64))

(test-begin "sum-of-multiples")

; (test-skip "no multiples within limit")
(test-eqv "no multiples within limit"
  (sum-of-multiples '(3 5) 1)
  0)

(test-skip "one factor has multiples within limit")
(test-eqv "one factor has multiples within limit"
  (sum-of-multiples '(3 5) 4)
  3)

(test-skip "more than one multiple within limit")
(test-eqv "more than one multiple within limit"
  (sum-of-multiples '(3) 7)
  9)

(test-skip "more than one factor with multiples within limit")
(test-eqv "more than one factor with multiples within limit"
  (sum-of-multiples '(3 5) 10)
  23)

(test-skip "each multiple is only counted once")
(test-eqv "each multiple is only counted once"
  (sum-of-multiples '(3 5) 100)
  2318)

(test-skip "a much larger limit")
(test-eqv "a much larger limit"
  (sum-of-multiples '(3 5) 1000)
  233168)

(test-skip "three factors")
(test-eqv "three factors"
  (sum-of-multiples '(7 13 17) 20)
  51)

(test-skip "factors not relatively prime")
(test-eqv "factors not relatively prime"
  (sum-of-multiples '(4 6) 15)
  30)

(test-skip "some pairs of factors relatively prime and some not")
(test-eqv "some pairs of factors relatively prime and some not"
  (sum-of-multiples '(5 6 8) 150)
  4419)

(test-skip "one factor is a multiple of another")
(test-eqv "one factor is a multiple of another"
  (sum-of-multiples '(5 25) 51)
  275)

(test-skip "much larger factors")
(test-eqv "much larger factors"
  (sum-of-multiples '(43 47) 10000)
  2203160)

(test-skip "all numbers are multiples of 1")
(test-eqv "all numbers are multiples of 1"
  (sum-of-multiples '(1) 100)
  4950)

(test-skip "no factors means an empty sum")
(test-eqv "no factors means an empty sum"
  (sum-of-multiples '() 10000)
  0)

(test-skip "the only multiple of 0 is 0")
(test-eqv "the only multiple of 0 is 0"
  (sum-of-multiples '(0) 1)
  0)

(test-skip "the factor 0 does not affect the sum of multiples of other factors")
(test-eqv "the factor 0 does not affect the sum of multiples of other factors"
  (sum-of-multiples '(3 0) 4)
  3)

(test-skip "solutions using include-exclude must extend to cardinality greater than 3")
(test-eqv "solutions using include-exclude must extend to cardinality greater than 3"
  (sum-of-multiples '(2 3 5 7 11) 10000)
  39614537)

(test-end "sum-of-multiples")
