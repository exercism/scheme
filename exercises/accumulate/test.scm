(load "accumulate.scm")

(use-modules (srfi srfi-64))

(define (square n)
  (* n n))

(define string-reverse (compose list->string reverse string->list))

(test-begin "accumulate")

; (test-skip "empty list")
(test-equal "empty list"
  (accumulate identity '()) '())

(test-skip "squares")
(test-equal "squares"
  (accumulate square '(1 2 3)) '(1 4 9))

(test-skip "upcases")
(test-equal "upcases"
  (accumulate string-upcase '("hello" "world")) '("HELLO" "WORLD"))

(test-skip "reverse strings")
(test-equal "reverse strings"
  (accumulate string-reverse '("the" "quick" "brown" "fox" "jumps" "over" "the" "lazy" "dog"))
  '("eht" "kciuq" "nworb" "xof" "spmuj" "revo" "eht" "yzal" "god"))

(test-end "accumulate")
