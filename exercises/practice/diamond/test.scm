; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/diamond/canonical-data.json
; File last updated on 2026-10-19T23:49:16+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. Degenerate case with a single 'A' row"
        equal? rows '(#\A)
        '("A"))

    (test-success "2. Degenerate case with no row containing 3 distinct groups of spaces"
        equal? rows '(#\B)
        '(" A "
          "B B"
          " A "))

    (test-success "3. Smallest non-degenerate case with odd diamond side length"
        equal? rows '(#\C)
        '("  A  "
          " B B "
          "C   C"
          " B B "
          "  A  "))

    (test-success "4. Smallest non-degenerate case with even diamond side length"
        equal? rows '(#\D)
        '("   A   "
          "  B B  "
          " C   C "
          "D     D"
          " C   C "
          "  B B  "
          "   A   "))

    (test-success "5. Largest possible diamond"
        equal? rows '(#\Z)
        '("                         A                         "
          "                        B B                        "
          "                       C   C                       "
          "                      D     D                      "
          "                     E       E                     "
          "                    F         F                    "
          "                   G           G                   "
          "                  H             H                  "
          "                 I               I                 "
          "                J                 J                "
          "               K                   K               "
          "              L                     L              "
          "             M                       M             "
          "            N                         N            "
          "           O                           O           "
          "          P                             P          "
          "         Q                               Q         "
          "        R                                 R        "
          "       S                                   S       "
          "      T                                     T      "
          "     U                                       U     "
          "    V                                         V    "
          "   W                                           W   "
          "  X                                             X  "
          " Y                                               Y "
          "Z                                                 Z"
          " Y                                               Y "
          "  X                                             X  "
          "   W                                           W   "
          "    V                                         V    "
          "     U                                       U     "
          "      T                                     T      "
          "       S                                   S       "
          "        R                                 R        "
          "         Q                               Q         "
          "          P                             P          "
          "           O                           O           "
          "            N                         N            "
          "             M                       M             "
          "              L                     L              "
          "               K                   K               "
          "                J                 J                "
          "                 I               I                 "
          "                  H             H                  "
          "                   G           G                   "
          "                    F         F                    "
          "                     E       E                     "
          "                      D     D                      "
          "                       C   C                       "
          "                        B B                        "
          "                         A                         "))))

(run-with-cli "diamond.scm" (list test-cases))
