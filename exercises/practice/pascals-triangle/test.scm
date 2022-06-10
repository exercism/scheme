(load "test-util.ss")

(define test-cases
  `((test-success "zero rows" equal? pascals-triangle '(0)
      '())
     (test-success "single row" equal? pascals-triangle '(1)
       '((1)))
     (test-success "two rows" equal? pascals-triangle '(2)
       '((1) (1 1)))
     (test-success "three rows" equal? pascals-triangle '(3)
       '((1) (1 1) (1 2 1)))
     (test-success "four rows" equal? pascals-triangle '(4)
       '((1) (1 1) (1 2 1) (1 3 3 1)))
     (test-success "five rows" equal? pascals-triangle '(5)
       '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1)))
     (test-success "six rows" equal? pascals-triangle '(6)
       '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1) (1 5 10 10 5 1)))
     (test-success "ten rows" equal? pascals-triangle '(10)
       '((1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1) (1 5 10 10 5 1)
             (1 6 15 20 15 6 1) (1 7 21 35 35 21 7 1)
             (1 8 28 56 70 56 28 8 1) (1 9 36 84 126 126 84 36 9 1)))))

(run-with-cli "pascals-triangle.scm" (list test-cases))

