; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/forth/canonical-data.json
; File last updated on 2026-10-21T19:37:08+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. parsing and numbers -> numbers just get pushed onto the stack"
        equal? forth '(("1 2 3 4 5"))
        '(5 4 3 2 1))

    (test-success "2. parsing and numbers -> pushes negative numbers onto the stack"
        equal? forth '(("-1 -2 -3 -4 -5"))
        '(-5 -4 -3 -2 -1))

    (test-success "3. addition -> can add two numbers"
        equal? forth '(("1 2 +"))
        '(3))

    (test-error "4. addition -> errors if there is nothing on the stack"
        forth '(("+")))

    (test-error "5. addition -> errors if there is only one value on the stack"
        forth '(("1 +")))

    (test-success "6. addition -> more than two values on the stack"
        equal? forth '(("1 2 3 +"))
        '(5 1))

    (test-success "7. subtraction -> can subtract two numbers"
        equal? forth '(("3 4 -"))
        '(-1))

    (test-error "8. subtraction -> errors if there is nothing on the stack"
        forth '(("-")))

    (test-error "9. subtraction -> errors if there is only one value on the stack"
        forth '(("1 -")))

    (test-success "10. subtraction -> more than two values on the stack"
        equal? forth '(("1 12 3 -"))
        '(9 1))

    (test-success "11. multiplication -> can multiply two numbers"
        equal? forth '(("2 4 *"))
        '(8))

    (test-error "12. multiplication -> errors if there is nothing on the stack"
        forth '(("*")))

    (test-error "13. multiplication -> errors if there is only one value on the stack"
        forth '(("1 *")))

    (test-success "14. multiplication -> more than two values on the stack"
        equal? forth '(("1 2 3 *"))
        '(6 1))

    (test-success "15. division -> can divide two numbers"
        equal? forth '(("12 3 /"))
        '(4))

    (test-success "16. division -> performs integer division"
        equal? forth '(("8 3 /"))
        '(2))

    (test-error "17. division -> errors if dividing by zero"
        forth '(("4 0 /")))

    (test-error "18. division -> errors if there is nothing on the stack"
        forth '(("/")))

    (test-error "19. division -> errors if there is only one value on the stack"
        forth '(("1 /")))

    (test-success "20. division -> more than two values on the stack"
        equal? forth '(("1 12 3 /"))
        '(4 1))

    (test-success "21. combined arithmetic -> addition and subtraction"
        equal? forth '(("1 2 + 4 -"))
        '(-1))

    (test-success "22. combined arithmetic -> multiplication and division"
        equal? forth '(("2 4 * 3 /"))
        '(2))

    (test-success "23. combined arithmetic -> multiplication and addition"
        equal? forth '(("1 3 4 * +"))
        '(13))

    (test-success "24. combined arithmetic -> addition and multiplication"
        equal? forth '(("1 3 4 + *"))
        '(7))

    (test-success "25. dup -> copies a value on the stack"
        equal? forth '(("1 dup"))
        '(1 1))

    (test-success "26. dup -> copies the top value on the stack"
        equal? forth '(("1 2 dup"))
        '(2 2 1))

    (test-error "27. dup -> errors if there is nothing on the stack"
        forth '(("dup")))

    (test-success "28. drop -> removes the top value on the stack if it is the only one"
        equal? forth '(("1 drop"))
        '())

    (test-success "29. drop -> removes the top value on the stack if it is not the only one"
        equal? forth '(("1 2 drop"))
        '(1))

    (test-error "30. drop -> errors if there is nothing on the stack"
        forth '(("drop")))

    (test-success "31. swap -> swaps the top two values on the stack if they are the only ones"
        equal? forth '(("1 2 swap"))
        '(1 2))

    (test-success "32. swap -> swaps the top two values on the stack if they are not the only ones"
        equal? forth '(("1 2 3 swap"))
        '(2 3 1))

    (test-error "33. swap -> errors if there is nothing on the stack"
        forth '(("swap")))

    (test-error "34. swap -> errors if there is only one value on the stack"
        forth '(("1 swap")))

    (test-success "35. over -> copies the second element if there are only two"
        equal? forth '(("1 2 over"))
        '(1 2 1))

    (test-success "36. over -> copies the second element if there are more than two"
        equal? forth '(("1 2 3 over"))
        '(2 3 2 1))

    (test-error "37. over -> errors if there is nothing on the stack"
        forth '(("over")))

    (test-error "38. over -> errors if there is only one value on the stack"
        forth '(("1 over")))

    (test-success "39. user-defined words -> can consist of built-in words"
        equal? forth '((": dup-twice dup dup ;" "1 dup-twice"))
        '(1 1 1))

    (test-success "40. user-defined words -> execute in the right order"
        equal? forth '((": countup 1 2 3 ;" "countup"))
        '(3 2 1))

    (test-success "41. user-defined words -> can override other user-defined words"
        equal? forth '((": foo dup ;" ": foo dup dup ;" "1 foo"))
        '(1 1 1))

    (test-success "42. user-defined words -> can override built-in words"
        equal? forth '((": swap dup ;" "1 swap"))
        '(1 1))

    (test-success "43. user-defined words -> can override built-in operators"
        equal? forth '((": + * ;" "3 4 +"))
        '(12))

    (test-success "44. user-defined words -> can use different words with the same name"
        equal? forth '((": foo 5 ;" ": bar foo ;" ": foo 6 ;" "bar foo"))
        '(6 5))

    (test-success "45. user-defined words -> can define word that uses word with the same name"
        equal? forth '((": foo 10 ;" ": foo foo 1 + ;" "foo"))
        '(11))

    (test-error "46. user-defined words -> cannot redefine non-negative numbers"
        forth '((": 1 2 ;")))

    (test-error "47. user-defined words -> cannot redefine negative numbers"
        forth '((": -1 2 ;")))

    (test-error "48. user-defined words -> errors if executing a non-existent word"
        forth '(("foo")))

    (test-success "49. user-defined words -> only defines locally"
        equal? (lambda (first second) (list (forth first) (forth second)))
        '((": + - ;" "1 1 +") ("1 1 +"))
        '((0) (2)))

    (test-success "50. case-insensitivity -> DUP is case-insensitive"
        equal? forth '(("1 DUP Dup dup"))
        '(1 1 1 1))

    (test-success "51. case-insensitivity -> DROP is case-insensitive"
        equal? forth '(("1 2 3 4 DROP Drop drop"))
        '(1))

    (test-success "52. case-insensitivity -> SWAP is case-insensitive"
        equal? forth '(("1 2 SWAP 3 Swap 4 swap"))
        '(1 4 3 2))

    (test-success "53. case-insensitivity -> OVER is case-insensitive"
        equal? forth '(("1 2 OVER Over over"))
        '(1 2 1 2 1))

    (test-success "54. case-insensitivity -> user-defined words are case-insensitive"
        equal? forth '((": foo dup ;" "1 FOO Foo foo"))
        '(1 1 1 1))

    (test-success "55. case-insensitivity -> definitions are case-insensitive"
        equal? forth '((": SWAP DUP Dup dup ;" "1 swap"))
        '(1 1 1 1))
    ))

(run-with-cli "forth.scm" (list test-cases))
