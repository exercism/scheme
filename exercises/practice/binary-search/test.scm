(load "test-util.ss")

(define test-cases
  `((test-success "finds a value in an array with one element"
      equal? binary-search '(#(6) 6) 0)
     (test-success "finds a value in the middle of an array"
       equal? binary-search '(#(1 3 4 6 8 9 11) 6) 3)
     (test-success "finds a value at the beginning of an array"
       equal? binary-search '(#(1 3 4 6 8 9 11) 1) 0)
     (test-success "finds a value at the end of an array" equal?
       binary-search '(#(1 3 4 6 8 9 11) 11) 6)
     (test-success "finds a value in an array of odd length" equal?
       binary-search
       '(#(1 3 5 8 13 21 34 55 89 144 233 377 634) 144) 9)
     (test-success "finds a value in an array of even length" equal?
       binary-search '(#(1 3 5 8 13 21 34 55 89 144 233 377) 21) 5)
     (test-success "identifies that a value is not included in the array"
       equal? binary-search '(#(1 3 4 6 8 9 11) 7) 'not-found)
     (test-success
       "a value smaller than the array's smallest value is not found"
       equal? binary-search '(#(1 3 4 6 8 9 11) 0) 'not-found)
     (test-success
       "a value larger than the array's largest value is not found"
       equal? binary-search '(#(1 3 4 6 8 9 11) 13) 'not-found)
     (test-success "nothing is found in an empty array" equal?
       binary-search '(#() 1) 'not-found)
     (test-success "nothing is found when the left and right bounds cross"
       equal? binary-search '(#(1 2) 0) 'not-found)))

(run-with-cli "binary-search.scm" (list test-cases))

