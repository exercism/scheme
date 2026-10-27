; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/secret-handshake/canonical-data.json
; File last updated on 2026-10-27T12:54:32+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. wink for 1"
        equal? commands '(1)
        '("wink"))

    (test-success "2. double blink for 10"
        equal? commands '(2)
        '("double blink"))

    (test-success "3. close your eyes for 100"
        equal? commands '(4)
        '("close your eyes"))

    (test-success "4. jump for 1000"
        equal? commands '(8)
        '("jump"))

    (test-success "5. combine two actions"
        equal? commands '(3)
        '("wink"
          "double blink"))

    (test-success "6. reverse two actions"
        equal? commands '(19)
        '("double blink"
          "wink"))

    (test-success "7. reversing one action gives the same action"
        equal? commands '(24)
        '("jump"))

    (test-success "8. reversing no actions still gives no actions"
        equal? commands '(16)
        '())

    (test-success "9. all possible actions"
        equal? commands '(15)
        '("wink"
          "double blink"
          "close your eyes"
          "jump"))

    (test-success "10. reverse all possible actions"
        equal? commands '(31)
        '("jump"
          "close your eyes"
          "double blink"
          "wink"))

    (test-success "11. do nothing for zero"
        equal? commands '(0)
        '())))

(run-with-cli "secret-handshake.scm" (list test-cases))
