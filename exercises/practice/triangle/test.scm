(load "triangle.scm")

(use-modules (srfi srfi-64))

(test-begin "triangle")

(test-begin "equilateral")

; (test-skip "equilateral: 2 2 2")
(test-eq "equilateral: 2 2 2"
  (triangle 2 2 2)
  'equilateral)

(test-skip "equilateral: 10 10 10")
(test-eq "equilateral: 10 10 10"
  (triangle 10 10 10)
  'equilateral)

(test-end "equilateral")

(test-begin "isosceles")

(test-skip "isosceles: 3 4 4")
(test-eq "isosceles: 3 4 4"
  (triangle 3 4 4)
  'isosceles)

(test-skip "isosceles: 4 3 4")
(test-eq "isosceles: 4 3 4"
  (triangle 4 3 4)
  'isosceles)

(test-skip "isosceles: 4 4 3")
(test-eq "isosceles: 4 4 3"
  (triangle 4 4 3)
  'isosceles)

(test-skip "isosceles: 10 10 2")
(test-eq "isosceles: 10 10 2"
  (triangle 10 10 2)
  'isosceles)

(test-end "isosceles")

(test-begin "scalene")

(test-skip "scalene: 3 4 5")
(test-eq "scalene: 3 4 5"
  (triangle 3 4 5)
  'scalene)

(test-skip "scalene: 10 11 12")
(test-eq "scalene: 10 11 12"
  (triangle 10 11 12)
  'scalene)

(test-skip "scalene: 5 4 2")
(test-eq "scalene: 5 4 2"
  (triangle 5 4 2)
  'scalene)

(test-end "scalene")

(test-begin "invalid")

(test-skip "invalid: 0 0 0")
(test-error "invalid: 0 0 0" #t
            (triangle 0 0 0))

(test-skip "invalid: 3 4 -5")
(test-error "invalid: 3 4 -5" #t
            (triangle 3 4 -5))

(test-skip "invalid: 1 1 3")
(test-error "invalid: 1 1 3" #t
            (triangle 1 1 3))

(test-skip "invalid: 2 4 2")
(test-error "invalid: 2 4 2" #t
            (triangle 2 4 2))

(test-end "invalid")

(test-end "triangle")
