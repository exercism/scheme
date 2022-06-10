(load "test-util.ss")

(define (under-10? n) (< n 10))

(define (starts-with-z? s) (char=? (string-ref s 0) #\z))

(define test-cases
  `((test-success "empty keep" equal? keep `(,under-10? ())
      '())
     (test-success "keep everything" equal? keep
       `(,under-10? (0 2 4 6 8)) '(0 2 4 6 8))
     (test-success "keep first last" equal? keep `(,odd? (1 2 3))
       '(1 3))
     (test-success "keep nothing" equal? keep
       `(,even? (1 3 5 7 9)) '())
     (test-success "keep neither first nor last" equal? keep
       `(,even? (1 2 3)) '(2))
     (test-success "keep strings" equal? keep
       `(,starts-with-z?
          ("apple" "zebra" "banana" "zombies" "cherimoya" "zealot"))
       '("zebra" "zombies" "zealot"))
     (test-success "empty discard" equal? discard
       `(,under-10? ()) '())
     (test-success "discard everything" equal? discard
       `(,under-10? (1 2 3)) '())
     (test-success "discard first and last" equal? discard
       `(,odd? (1 2 3)) '(2))
     (test-success "discard nothing" equal? discard
       `(,even? (1 3 5 7 9)) '(1 3 5 7 9))
     (test-success "discard neither first nor last" equal?
       discard `(,even? (1 2 3)) '(1 3))
     (test-success "discard strings" equal? discard
       `(,starts-with-z?
          ("apple" "zebra" "banana" "zombies" "cherimoya" "zealot"))
       '("apple" "banana" "cherimoya"))))

(run-with-cli "strain.scm" (list test-cases))

