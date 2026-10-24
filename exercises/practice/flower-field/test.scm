; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/flower-field/canonical-data.json
; File last updated on 2026-10-25T04:39:02+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. no rows"
        equal? annotate
        '(())

         '())

    (test-success "2. no columns"
        equal? annotate
        '((""))

         '(""))

    (test-success "3. no flowers"
        equal? annotate
        '(("   "
           "   "
           "   "))

         '("   "
           "   "
           "   "))

    (test-success "4. garden full of flowers"
        equal? annotate
        '(("***"
           "***"
           "***"))

         '("***"
           "***"
           "***"))

    (test-success "5. flower surrounded by spaces"
        equal? annotate
        '(("   "
           " * "
           "   "))

         '("111"
           "1*1"
           "111"))

    (test-success "6. space surrounded by flowers"
        equal? annotate
        '(("***"
           "* *"
           "***"))

         '("***"
           "*8*"
           "***"))

    (test-success "7. horizontal line"
        equal? annotate
        '((" * * "))

         '("1*2*1"))

    (test-success "8. horizontal line, flowers at edges"
        equal? annotate
        '(("*   *"))

         '("*1 1*"))

    (test-success "9. vertical line"
        equal? annotate
        '((" "
           "*"
           " "
           "*"
           " "))

         '("1"
           "*"
           "2"
           "*"
           "1"))

    (test-success "10. vertical line, flowers at edges"
        equal? annotate
        '(("*"
           " "
           " "
           " "
           "*"))

         '("*"
           "1"
           " "
           "1"
           "*"))

    (test-success "11. cross"
        equal? annotate
        '(("  *  "
           "  *  "
           "*****"
           "  *  "
           "  *  "))

         '(" 2*2 "
           "25*52"
           "*****"
           "25*52"
           " 2*2 "))

    (test-success "12. large garden"
        equal? annotate
        '((" *  * "
           "  *   "
           "    * "
           "   * *"
           " *  * "
           "      "))

         '("1*22*1"
           "12*322"
           " 123*2"
           "112*4*"
           "1*22*2"
           "111111"))

    (test-success "13. multiple adjacent flowers"
        equal? annotate
        '((" ** "))

         '("1**1"))))

(run-with-cli "flower-field.scm" (list test-cases))
