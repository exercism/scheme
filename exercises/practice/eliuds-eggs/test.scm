; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/eliuds-eggs/canonical-data.json
; File last updated on 2026-10-19T09:41:25+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. 0 eggs"
        equal? egg-count '(0) 0)

    (test-success "2. 1 egg"
        equal? egg-count '(16) 1)

    (test-success "3. 4 eggs"
        equal? egg-count '(89) 4)

    (test-success "4. 13 eggs"
        equal? egg-count '(2000000000) 13)
    ))

(run-with-cli "eliuds-eggs.scm" (list test-cases))
