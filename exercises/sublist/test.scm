(load "sublist.scm")

(use-modules (srfi srfi-64))

(test-begin "sublist")

; (test-skip "empty lists")
(test-eq "empty lists"
  (sublist '() '())
  'equal)

(test-skip "empty list within non-empty list")
(test-eq "empty list within non-empty list"
  (sublist '() '(1 2 3))
  'sublist)

(test-skip "non empty list contains empty list")
(test-eq "non empty list contains empty list"
  (sublist '(1 2 3) '())
  'superlist)

(test-skip "list equals itself")
(test-eq "list equals itself"
  (sublist '(1 2 3) '(1 2 3))
  'equal)

(test-skip "different lists")
(test-eq "different lists"
  (sublist '(1 2 3) '(2 3 4))
  'unequal)

(test-skip "false start")
(test-eq "false start"
  (sublist '(1 2 5) '(0 1 2 3 1 2 5 6))
  'sublist)

(test-skip "consecutive")
(test-eq "consecutive"
  (sublist '(1 1 2) '(0 1 1 1 2 1 2))
  'sublist)

(test-skip "sublist at start")
(test-eq "sublist at start"
  (sublist '(0 1 2) '(0 1 2 3 4 5))
  'sublist)

(test-skip "sublist in middle")
(test-eq "sublist in middle"
  (sublist '(2 3 4) '(0 1 2 3 4 5))
  'sublist)

(test-skip "sublist at end")
(test-eq "sublist at end"
  (sublist '(3 4 5) '(0 1 2 3 4 5))
  'sublist)

(test-skip "at start of superlist")
(test-eq "at start of superlist"
  (sublist '(0 1 2 3 4 5) '(0 1 2))
  'superlist)

(test-skip "in middle of superlist")
(test-eq "in middle of superlist"
  (sublist '(0 1 2 3 4 5) '(2 3))
  'superlist)

(test-skip "at end of superlist")
(test-eq "at end of superlist"
  (sublist '(0 1 2 3 4 5) '(3 4 5))
  'superlist)

(test-skip "first list missing elements from second list")
(test-eq "first list missing elements from second list"
  (sublist '(1 3) '(1 2 3))
  'unequal)

(test-skip "second list missing element from first list")
(test-eq "second list missing element from first list"
  (sublist '(1 2 3) '(1 3))
  'unequal)

(test-skip "order matters to a list")
(test-eq "order matters to a list"
  (sublist '(1 2 3) '(3 2 1))
  'unequal)

(test-skip "same digits different numbers")
(test-eq "same digits different numbers"
  (sublist '(1 0 1) '(10 1))
  'unequal)

(test-end "sublist")
