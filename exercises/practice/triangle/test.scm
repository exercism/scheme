(load "test-util.ss")

(define test-cases
  `((test-success "equilateral: 2 2 2" equal? triangle
      '(2 2 2) 'equilateral)
     (test-success "equilateral: 10 10 10" equal? triangle
       '(10 10 10) 'equilateral)
     (test-success "isosceles: 3 4 4" equal? triangle '(3 4 4)
       'isosceles)
     (test-success "isosceles: 4 3 4" equal? triangle '(4 3 4)
       'isosceles)
     (test-success "isosceles: 4 4 3" equal? triangle '(4 4 3)
       'isosceles)
     (test-success "isosceles: 10 10 2" equal? triangle
       '(10 10 2) 'isosceles)
     (test-success "scalene: 3 4 5" equal? triangle '(3 4 5)
       'scalene)
     (test-success "scalene: 10 11 12" equal? triangle
       '(10 11 12) 'scalene)
     (test-success "scalene: 5 4 2" equal? triangle '(5 4 2)
       'scalene)
     (test-error "invalid: 0 0 0" triangle '(0 0 0))
     (test-error "invalid: 3 4 -5" triangle '(3 4 -5))
     (test-error "invalid: 1 1 3" triangle '(1 1 3))
     (test-error "invalid: 2 4 2" triangle '(2 4 2))))

(run-with-cli "triangle.scm" (list test-cases))

