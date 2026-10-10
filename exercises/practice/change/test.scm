; These tests are auto-generated with test data from: 
; https://github.com/exercism/problem-specifications/blob/main/exercises/change/canonical-data.json
; File last updated on 2026-10-10T20:03:07+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. change for 1 cent"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(1 (1 5 10 25))
        `(1))
    (test-success "2. single coin change"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(25 (1 5 10 25 100))
        `(25))
    (test-success "3. multiple coin change"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(15 (1 5 10 25 100))
        `(5 10))
    (test-success "4. change with Lilliputian Coins"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(23 (1 4 15 20 50))
        `(4 4 15))
    (test-success "5. change with Lower Elbonia Coins"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(63 (1 5 10 21 25))
        `(21 21 21))
    (test-success "6. large target values"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(999 (1 2 5 10 20 50 100))
        `(2 2 5 20 20 50 100 100 100 100 100 100 100 100 100))
    (test-success "7. possible change without unit coins available"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(21 (2 5 10 20 50))
        `(2 2 2 5 10))
    (test-success "8. another possible change without unit coins available"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(27 (4 5))
        `(4 4 4 5 5 5))
    (test-success "9. a greedy approach is not optimal"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(20 (1 10 11))
        `(10 10))
    (test-success "10. no coins make 0 change"
        (lambda (out expected)
            (equal? (list-sort < out) (list-sort < expected)))
        change '(0 (1 5 10 21 25))
        `())
    (test-error "error testing for change smaller than the smallest of coins" 
        change '(3 (5 10)))
    (test-error "error if no combination can add up to target" 
        change '(94 (5 10)))
    (test-error "cannot find negative change values" 
        change '(-5 (1 2 5)))
    ))

(run-with-cli "change.scm" (list test-cases))


