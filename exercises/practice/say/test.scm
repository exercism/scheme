; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/say/canonical-data.json
; File last updated on 2026-10-20T04:43:09+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. zero"
        string=? say '(0)
        "zero")
    (test-success "2. one"
        string=? say '(1)
        "one")
    (test-success "3. fourteen"
        string=? say '(14)
        "fourteen")
    (test-success "4. twenty"
        string=? say '(20)
        "twenty")
    (test-success "5. twenty-two"
        string=? say '(22)
        "twenty-two")
    (test-success "6. thirty"
        string=? say '(30)
        "thirty")
    (test-success "7. ninety-nine"
        string=? say '(99)
        "ninety-nine")
    (test-success "8. one hundred"
        string=? say '(100)
        "one hundred")
    (test-success "9. one hundred twenty-three"
        string=? say '(123)
        "one hundred twenty-three")
    (test-success "10. two hundred"
        string=? say '(200)
        "two hundred")
    (test-success "11. nine hundred ninety-nine"
        string=? say '(999)
        "nine hundred ninety-nine")
    (test-success "12. one thousand"
        string=? say '(1000)
        "one thousand")
    (test-success "13. one thousand two hundred thirty-four"
        string=? say '(1234)
        "one thousand two hundred thirty-four")
    (test-success "14. one million"
        string=? say '(1000000)
        "one million")
    (test-success "15. one million two thousand three hundred forty-five"
        string=? say '(1002345)
        "one million two thousand three hundred forty-five")
    (test-success "16. one billion"
        string=? say '(1000000000)
        "one billion")
    (test-success "17. a big number"
        string=? say '(987654321123)
        "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three")
    (test-error "18. numbers below zero are out of range"
        say '(-1))
    (test-error "19. numbers above 999,999,999,999 are out of range"
        say '(1000000000000))
    (test-success "20. additional big number"
        string=? say '(19011016013)
        "nineteen billion eleven million sixteen thousand thirteen")
    (test-success "21. different big number"
        string=? say '(812000070017)
        "eight hundred twelve billion seventy thousand seventeen")
    (test-success "22. alternative big number"
        string=? say '(60010015018)
        "sixty billion ten million fifteen thousand eighteen")
    ))

(run-with-cli "say.scm" (list test-cases))
