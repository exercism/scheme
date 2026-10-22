; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/prime-factors/canonical-data.json
; File last updated on 2026-10-22T16:00:35+00:00

(load "test-util.ss")

; Compare lists of factors ignoring order.
(define (is-equal? xs ys)
  (equal? (list-sort < xs) (list-sort < ys)))

(define test-cases
  `(
    (test-success "1. no factors"
        is-equal? factorize '(1) '())

    (test-success "2. prime number"
        is-equal? factorize '(2) '(2))

    (test-success "3. another prime number"
        is-equal? factorize '(3) '(3))

    (test-success "4. square of a prime"
        is-equal? factorize '(9) '(3 3))

    (test-success "5. product of first prime"
        is-equal? factorize '(4) '(2 2))

    (test-success "6. cube of a prime"
        is-equal? factorize '(8) '(2 2 2))

    (test-success "7. product of second prime"
        is-equal? factorize '(27) '(3 3 3))

    (test-success "8. product of third prime"
        is-equal? factorize '(625) '(5 5 5 5))

    (test-success "9. product of first and second prime"
        is-equal? factorize '(6) '(2 3))

    (test-success "10. product of primes and non-primes"
        is-equal? factorize '(12) '(2 2 3))

    (test-success "11. product of primes"
        is-equal? factorize '(901255) '(5 17 23 461))

    (test-success "12. factors include a large prime"
        is-equal? factorize '(93819012551) '(11 9539 894119))
    ))

(run-with-cli "prime-factors.scm" (list test-cases))
