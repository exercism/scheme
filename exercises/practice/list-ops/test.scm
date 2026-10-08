; These tests are auto-generated with test data from: 
; https://github.com/exercism/problem-specifications/blob/main/exercises/list-ops/canonical-data.json
; File last updated on 2026-10-08T23:25:43+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. empty lists" 
        equal? my-append '(() ())
        '())
    (test-success "2. list to empty list" 
        equal? my-append '(() (1 2 3 4))
        '(1 2 3 4))
    (test-success "3. empty list to list" 
        equal? my-append '((1 2 3 4) ())
        '(1 2 3 4))
    (test-success "4. non-empty lists" 
        equal? my-append '((1 2) (2 3 4 5))
        '(1 2 2 3 4 5))
    (test-success "5. empty list" 
        equal? my-concatenate '(())
        '())
    (test-success "6. list of lists" 
        equal? my-concatenate '(((1 2) (3) () (4 5 6)))
        '(1 2 3 4 5 6))
    (test-success "7. list of nested lists" 
        equal? my-concatenate '((((1) (2)) ((3)) (()) ((4 5 6))))
        '((1) (2) (3) () (4 5 6)))
    (test-success "8. empty list" 
        equal? my-filter (list odd? '())
        '())
    (test-success "9. non-empty list" 
        equal? my-filter (list odd? '(1 2 3 5))
        '(1 3 5))
    ))

(run-with-cli "list-ops.scm" (list test-cases))
