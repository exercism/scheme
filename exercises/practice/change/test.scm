(load "test-util.ss")

(define test-cases
  `((test-success "single coin change"
      (lambda (out expected)
        (equal? (list-sort < out) (list-sort < expected)))
      change '(25 (1 5 10 25 100)) '(25))
     (test-success "multiple coin change"
       (lambda (out expected)
         (equal? (list-sort < out) (list-sort < expected)))
       change '(15 (1 5 10 25 100)) '(5 10))
     (test-success "change with Lilliputian Coins"
       (lambda (out expected)
         (equal? (list-sort < out) (list-sort < expected)))
       change '(23 (1 4 15 20 50)) '(4 4 15))
     (test-success "change with Lower Elbonia Coins"
       (lambda (out expected)
         (equal? (list-sort < out) (list-sort < expected)))
       change '(63 (1 5 10 21 25)) '(21 21 21))
     (test-success "large target values"
       (lambda (out expected)
         (equal? (list-sort < out) (list-sort < expected)))
       change '(999 (1 2 5 10 20 50 100))
       '(2 2 5 20 20 50 100 100 100 100 100 100 100 100 100))
     (test-success "possible change without unit coins available"
       (lambda (out expected)
         (equal? (list-sort < out) (list-sort < expected)))
       change '(21 (2 5 10 20 50)) '(2 2 2 5 10))
     (test-success "another possible change without unit coins available"
       (lambda (out expected)
         (equal? (list-sort < out) (list-sort < expected)))
       change '(27 (4 5)) '(4 4 4 5 5 5))
     (test-success "no coins make 0 change"
       (lambda (out expected)
         (equal? (list-sort < out) (list-sort < expected)))
       change '(0 (1 5 10 21 25)) '())
     (test-error
       "error testing for change smaller than the smallest of coins"
       change
       '(3 (5 10)))
     (test-error
       "error if no combination can add up to target"
       change
       '(94 (5 10)))
     (test-error
       "cannot find negative change values"
       change
       '(-5 (1 2 5)))))

(run-with-cli "change.scm" (list test-cases))

