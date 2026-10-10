; These tests are auto-generated with test data from: 
; https://github.com/exercism/problem-specifications/blob/main/exercises/triangle/canonical-data.json
; File last updated on 2026-10-10T19:00:47+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. equilateral: all sides are equal"
        equal? triangle '(2 2 2) 'equilateral)
    (test-success "2. equilateral: any side is unequal"
        equal? triangle '(2 3 2) 'isosceles)
    (test-success "3. equilateral: no sides are equal"
        equal? triangle '(5 4 6) 'scalene)
    (test-error "4. equilateral: all zero sides is not a triangle"
        triangle '(0 0 0))
    (test-success "5. equilateral: sides may be floats"
        equal? triangle '(0.5 0.5 0.5) 'equilateral)
    (test-success "6. isosceles: last two sides are equal"
        equal? triangle '(3 4 4) 'isosceles)
    (test-success "7. isosceles: first two sides are equal"
        equal? triangle '(4 4 3) 'isosceles)
    (test-success "8. isosceles: first and last sides are equal"
        equal? triangle '(4 3 4) 'isosceles)
    (test-success "9. isosceles: no sides are equal"
        equal? triangle '(2 3 4) 'scalene)
    (test-error "10. isosceles: first triangle inequality violation"
        triangle '(1 1 3))
    (test-error "11. isosceles: second triangle inequality violation"
        triangle '(1 3 1))
    (test-error "12. isosceles: third triangle inequality violation"
        triangle '(3 1 1))
    (test-success "13. isosceles: sides may be floats"
        equal? triangle '(0.5 0.4 0.5) 'isosceles)
    (test-success "14. scalene: no sides are equal"
        equal? triangle '(5 4 6) 'scalene)
    (test-success "15. scalene: all sides are equal"
        equal? triangle '(4 4 4) 'equilateral)
    (test-success "16. scalene: first and second sides are equal"
        equal? triangle '(4 4 3) 'isosceles)
    (test-success "17. scalene: first and third sides are equal"
        equal? triangle '(3 4 3) 'isosceles)
    (test-success "18. scalene: second and third sides are equal"
        equal? triangle '(4 3 3) 'isosceles)
    (test-error "19. scalene: may not violate triangle inequality"
        triangle '(7 3 2))
    (test-success "20. scalene: sides may be floats"
        equal? triangle '(0.5 0.4 0.6) 'scalene)
    ))

(run-with-cli "triangle.scm" (list test-cases))
