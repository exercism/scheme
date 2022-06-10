(load "test-util.ss")

(define test-cases
  `((test-success "the sound for 1 is 1" equal? convert '(1)
      "1")
     (test-success "the sound for 3 is Pling" equal? convert '(3)
       "Pling")
     (test-success "the sound for 5 is Plang" equal? convert '(5)
       "Plang")
     (test-success "the sound for 7 is Plong" equal? convert '(7)
       "Plong")
     (test-success
       "the sound for 6 is Pling as it has a factor 3" equal?
       convert '(6) "Pling")
     (test-success
       "2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base"
       equal? convert '(8) "8")
     (test-success
       "the sound for 9 is Pling as it has a factor 3" equal?
       convert '(9) "Pling")
     (test-success
       "the sound for 10 is Plang as it has a factor 5" equal?
       convert '(10) "Plang")
     (test-success
       "the sound for 14 is Plong as it has a factor of 7" equal?
       convert '(14) "Plong")
     (test-success
       "the sound for 15 is PlingPlang as it has factors 3 and 5"
       equal? convert '(15) "PlingPlang")
     (test-success
       "the sound for 21 is PlingPlong as it has factors 3 and 7"
       equal? convert '(21) "PlingPlong")
     (test-success
       "the sound for 25 is Plang as it has a factor 5" equal?
       convert '(25) "Plang")
     (test-success
       "the sound for 27 is Pling as it has a factor 3" equal?
       convert '(27) "Pling")
     (test-success
       "the sound for 35 is PlangPlong as it has factors 5 and 7"
       equal? convert '(35) "PlangPlong")
     (test-success
       "the sound for 49 is Plong as it has a factor 7" equal?
       convert '(49) "Plong")
     (test-success "the sound for 52 is 52" equal? convert '(52)
       "52")
     (test-success
       "the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7"
       equal? convert '(105) "PlingPlangPlong")
     (test-success
       "the sound for 3125 is Plang as it has a factor 5" equal?
       convert '(3125) "Plang")))

(run-with-cli "raindrops.scm" (list test-cases))

