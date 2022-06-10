(load "test-util.ss")

(define test-cases
  `((test-success "can not attack" eq? attacking?
      '((2 4) (6 6)) #f)
     (test-success "can attack on same row" eq? attacking?
       '((2 4) (2 6)) #t)
     (test-success "can attack on same column" eq? attacking?
       '((4 5) (2 5)) #t)
     (test-success "can attack on first diagonal" eq? attacking?
       '((2 2) (0 4)) #t)
     (test-success "can attack on second diagonal" eq? attacking?
       '((2 2) (3 1)) #t)
     (test-success "can attack on third diagonal" eq? attacking?
       '((2 2) (1 1)) #t)
     (test-success "can attack on fourth diagonal" eq? attacking?
       '((1 7) (0 6)) #t)))

(run-with-cli "queen-attack.scm" (list test-cases))

