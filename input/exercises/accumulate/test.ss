(define accumulate-tests
`((test-success "empty list" equal? accumulate '((lambda (x) x) '()) '())
  (test-success "square numbers" equal? accumulate '((lambda (x) (* x x)) '(1 2 3)) '(1 4 9))))

(put-problem!
   'accumullate
   `((test ,accumulate-tests)
     (stubs accumulate)
     (version . "0.0")
     (skeleton . "accumulate.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism 'accumulate))))

