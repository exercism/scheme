; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/two-fer/canonical-data.json
; File last updated on 2026-10-21T17:05:26+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. no name given" equal? two-fer '() "One for you, one for me.")

    (test-success "2. a name given" equal? two-fer '("Alice") "One for Alice, one for me.")

    (test-success "3. another name given" equal? two-fer '("Bob") "One for Bob, one for me.")
    ))

(run-with-cli "two-fer.scm" (list test-cases))
