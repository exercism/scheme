; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/wordy/canonical-data.json
; File last updated on 2026-10-21T07:57:17+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. just a number"
        = answer '("What is 5?")
        5)
    (test-success "2. just a zero"
        = answer '("What is 0?")
        0)
    (test-success "3. just a negative number"
        = answer '("What is -123?")
        -123)
    (test-success "4. addition"
        = answer '("What is 1 plus 1?")
        2)
    (test-success "5. addition with a left hand zero"
        = answer '("What is 0 plus 2?")
        2)
    (test-success "6. addition with a right hand zero"
        = answer '("What is 3 plus 0?")
        3)
    (test-success "7. more addition"
        = answer '("What is 53 plus 2?")
        55)
    (test-success "8. addition with negative numbers"
        = answer '("What is -1 plus -10?")
        -11)
    (test-success "9. large addition"
        = answer '("What is 123 plus 45678?")
        45801)
    (test-success "10. subtraction"
        = answer '("What is 4 minus -12?")
        16)
    (test-success "11. multiplication"
        = answer '("What is -3 multiplied by 25?")
        -75)
    (test-success "12. division"
        = answer '("What is 33 divided by -3?")
        -11)
    (test-success "13. multiple additions"
        = answer '("What is 1 plus 1 plus 1?")
        3)
    (test-success "14. addition and subtraction"
        = answer '("What is 1 plus 5 minus -2?")
        8)
    (test-success "15. multiple subtraction"
        = answer '("What is 20 minus 4 minus 13?")
        3)
    (test-success "16. subtraction then addition"
        = answer '("What is 17 minus 6 plus 3?")
        14)
    (test-success "17. multiple multiplication"
        = answer '("What is 2 multiplied by -2 multiplied by 3?")
        -12)
    (test-success "18. addition and multiplication"
        = answer '("What is -3 plus 7 multiplied by -2?")
        -8)
    (test-success "19. multiple division"
        = answer '("What is -12 divided by 2 divided by -3?")
        2)
    (test-error "20. unknown operation"
        answer '("What is 52 cubed?"))
    (test-error "21. Non math question"
        answer '("Who is the President of the United States?"))
    (test-error "22. reject problem missing an operand"
        answer '("What is 1 plus?"))
    (test-error "23. reject problem with no operands or operators"
        answer '("What is?"))
    (test-error "24. reject two operations in a row"
        answer '("What is 1 plus plus 2?"))
    (test-error "25. reject two numbers in a row"
        answer '("What is 1 plus 2 1?"))
    (test-error "26. reject postfix notation"
        answer '("What is 1 2 plus?"))
    (test-error "27. reject prefix notation"
        answer '("What is plus 1 2?"))
    ))

(run-with-cli "wordy.scm" (list test-cases))
