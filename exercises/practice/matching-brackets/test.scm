; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/matching-brackets/canonical-data.json
; File last updated on 2026-10-19T18:43:09+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. paired square brackets"
      eq? balanced? '("[]") #t)

    (test-success "2. empty string"
      eq? balanced? '("") #t)

    (test-success "3. unpaired brackets"
      eq? balanced? '("[[") #f)

    (test-success "4. wrong ordered brackets"
      eq? balanced? '("}{") #f)

    (test-success "5. wrong closing bracket"
      eq? balanced? '("{]") #f)

    (test-success "6. paired with whitespace"
      eq? balanced? '("{ }") #t)

    (test-success "7. partially paired brackets"
      eq? balanced? '("{[])") #f)

    (test-success "8. simple nested brackets"
      eq? balanced? '("{[]}") #t)

    (test-success "9. several paired brackets"
      eq? balanced? '("{}[]") #t)

    (test-success "10. paired and nested brackets"
      eq? balanced? '("([{}({}[])])") #t)

    (test-success "11. unopened closing brackets"
      eq? balanced? '("{[)][]}") #f)

    (test-success "12. unpaired and nested brackets"
      eq? balanced? '("([{])") #f)

    (test-success "13. paired and wrong nested brackets"
      eq? balanced? '("[({]})") #f)

    (test-success "14. paired and wrong nested brackets but innermost are correct"
      eq? balanced? '("[({}])") #f)

    (test-success "15. paired and incomplete brackets"
      eq? balanced? '("{}[") #f)

    (test-success "16. too many closing brackets"
      eq? balanced? '("[]]") #f)

    (test-success "17. early unexpected brackets"
      eq? balanced? '(")()") #f)

    (test-success "18. early mismatched brackets"
      eq? balanced? '("{)()") #f)

    (test-success "19. math expression"
      eq? balanced? '("(((185 + 223.85) * 15) - 543)/2") #t)

    (test-success "20. complex latex expression"
      eq? balanced? '("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)") #t)
    ))

(run-with-cli "matching-brackets.scm" (list test-cases))
