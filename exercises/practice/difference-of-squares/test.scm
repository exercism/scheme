(load "test-util.ss")

(define test-cases
  `((test-success "square of sum 1" = square-of-sum '(1) 1) (test-success "square of sum 5" = square-of-sum '(5) 225)
     (test-success "square of sum 100" = square-of-sum '(100)
       25502500)
     (test-success "sum of squares 1" = sum-of-squares '(1) 1)
     (test-success "sum of squares 5" = sum-of-squares '(5) 55)
     (test-success "sum of squares 100" = sum-of-squares '(100)
       338350)
     (test-success "difference of squares 1" =
       difference-of-squares '(1) 0)
     (test-success "difference of squares 5" =
       difference-of-squares '(5) 170)
     (test-success "difference of squares 100" =
       difference-of-squares '(100) 25164150)))

(run-with-cli "difference-of-squares.scm" (list test-cases))

