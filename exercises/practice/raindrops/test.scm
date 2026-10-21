; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/raindrops/canonical-data.json
; File last updated on 2026-10-21T17:00:07+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. the sound for 1 is 1" equal? convert '(1) "1")

    (test-success "2. the sound for 3 is Pling" equal? convert '(3) "Pling")

    (test-success "3. the sound for 5 is Plang" equal? convert '(5) "Plang")

    (test-success "4. the sound for 7 is Plong" equal? convert '(7) "Plong")

    (test-success "5. the sound for 6 is Pling as it has a factor 3" equal? convert '(6) "Pling")

    (test-success "6. 2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base" equal? convert '(8) "8")

    (test-success "7. the sound for 9 is Pling as it has a factor 3" equal? convert '(9) "Pling")

    (test-success "8. the sound for 10 is Plang as it has a factor 5" equal? convert '(10) "Plang")

    (test-success "9. the sound for 14 is Plong as it has a factor of 7" equal? convert '(14) "Plong")

    (test-success "10. the sound for 15 is PlingPlang as it has factors 3 and 5" equal? convert '(15) "PlingPlang")

    (test-success "11. the sound for 21 is PlingPlong as it has factors 3 and 7" equal? convert '(21) "PlingPlong")

    (test-success "12. the sound for 25 is Plang as it has a factor 5" equal? convert '(25) "Plang")

    (test-success "13. the sound for 27 is Pling as it has a factor 3" equal? convert '(27) "Pling")

    (test-success "14. the sound for 35 is PlangPlong as it has factors 5 and 7" equal? convert '(35) "PlangPlong")

    (test-success "15. the sound for 49 is Plong as it has a factor 7" equal? convert '(49) "Plong")

    (test-success "16. the sound for 52 is 52" equal? convert '(52) "52")

    (test-success "17. the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7" equal? convert '(105) "PlingPlangPlong")

    (test-success "18. the sound for 3125 is Plang as it has a factor 5" equal? convert '(3125) "Plang")
    ))

(run-with-cli "raindrops.scm" (list test-cases))
