; These tests are auto-generated with test data from: 
; https://github.com/exercism/problem-specifications/blob/main/exercises/list-ops/canonical-data.json
; File last updated on 2026-10-09T22:38:09+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. append: empty lists"
        equal? my-append '(() ())
        '())
    (test-success "2. append: list to empty list"
        equal? my-append '(() (1 2 3 4))
        '(1 2 3 4))
    (test-success "3. append: empty list to list"
        equal? my-append '((1 2 3 4) ())
        '(1 2 3 4))
    (test-success "4. append: non-empty lists"
        equal? my-append '((1 2) (2 3 4 5))
        '(1 2 2 3 4 5))
    (test-success "5. concat: empty list"
        equal? my-concatenate '(())
        '())
    (test-success "6. concat: list of lists"
        equal? my-concatenate '(((1 2) (3) () (4 5 6)))
        '(1 2 3 4 5 6))
    (test-success "7. concat: list of nested lists"
        equal? my-concatenate '((((1) (2)) ((3)) (()) ((4 5 6))))
        '((1) (2) (3) () (4 5 6)))
    (test-success "8. filter: empty list"
        equal? my-filter '(,(lambda (x) (odd? x)) ())
        '())
    (test-success "9. filter: non-empty list"
        equal? my-filter '(,(lambda (x) (odd? x)) (1 2 3 5))
        '(1 3 5))
    (test-success "10. length: empty list"
        = my-length '(())
        0)
    (test-success "11. length: non-empty list"
        = my-length '((1 2 3 4))
        4)
    (test-success "12. map: empty list"
        equal? my-map '(,(lambda (x) (+ x 1)) ())
        '())
    (test-success "13. map: non-empty list"
        equal? my-map '(,(lambda (x) (+ x 1)) (1 3 5 7))
        '(2 4 6 8))
    (test-success "14. foldl: empty list"
        = my-foldl '(,(lambda (el acc) (* el acc)) 2 ())
        2)
    (test-success "15. foldl: direction independent function applied to non-empty list"
        = my-foldl '(,(lambda (el acc) (+ el acc)) 5 (1 2 3 4))
        15)
    (test-success "16. foldl: direction dependent function applied to non-empty list"
        = my-foldl '(,(lambda (el acc) (/ el acc)) 24 (1 2 3 4))
        64)
    (test-success "17. foldr: empty list"
        = my-foldr '(,(lambda (el acc) (* el acc)) 2 ())
        2)
    (test-success "18. foldr: direction independent function applied to non-empty list"
        = my-foldr '(,(lambda (el acc) (+ el acc)) 5 (1 2 3 4))
        15)
    (test-success "19. foldr: direction dependent function applied to non-empty list"
        = my-foldr '(,(lambda (el acc) (/ el acc)) 24 (1 2 3 4))
        9)
    (test-success "20. reverse: empty list"
        equal? my-reverse '(())
        '())
    (test-success "21. reverse: non-empty even-length list"
        equal? my-reverse '((1 3 5 7))
        '(7 5 3 1))
    (test-success "22. reverse: non-empty odd-length list"
        equal? my-reverse '((1 3 5 7 9 11 13))
        '(13 11 9 7 5 3 1))
    (test-success "23. reverse: list of lists is not flattened"
        equal? my-reverse '(((1 2) (3) () (4 5 6)))
        '((4 5 6) () (3) (1 2)))
    ))

(run-with-cli "list-ops.scm" (list test-cases))
