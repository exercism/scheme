;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))
(use-modules (srfi srfi-1))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require list-ops impl
(add-to-load-path (dirname (current-filename)))
(use-modules (list-ops))

;;; Begin test suite
(test-begin "list-ops-test")

(test-eqv "length of empty list"
           0
           (my-length '()))

(test-eqv "length of normal list"
           4
           (my-length '(1 3 5 7)))

(test-eqv "length of huge list"
          1000000
          (my-length (list-tabulate 1000000 values)))

(test-equal "reverse of empty list"
            '()
            (my-reverse '()))

(test-equal "reverse of normal list"
            '(7 5 3 1)
            (my-reverse '(1 3 5 7)))

(test-equal "reverse of huge list"
            (list-tabulate 1000000 (lambda (x) (- 999999 x)))
            (my-reverse (list-tabulate 1000000 values)))

(define (inc x) (+ 1 x))

(test-equal "map of empty list"
            '()
            (my-map inc '()))

(test-equal "map of normal list"
            '(2 3 4 5)
            (my-map inc '(1 2 3 4)))

(test-equal "map of huge list"
            (list-tabulate 1000000 (lambda (x) (+ x 1)))
            (my-map inc (list-tabulate 1000000 values)))

(test-equal "filter of empty list"
            '()
            (my-filter odd? '()))

(test-equal "filter of normal list"
            '(1 3)
            (my-filter odd? '(1 2 3 4)))

(test-equal "filter of huge list"
            (filter odd? (list-tabulate 1000000 values))
            (my-filter odd? (list-tabulate 1000000 values)))

(test-eqv "fold of empty list"
          0
          (my-fold + 0 '()))

(test-eqv "fold of normal list"
          7
          (my-fold + -3 '(1 2 3 4)))

(test-eqv "fold of huge list"
          (fold + 0 (list-tabulate 1000000 values))
          (my-fold + 0 (list-tabulate 1000000 values)))

(test-eqv "fold with non-commutative function"
          0
          (my-fold (lambda (x acc) (- acc x))
                   10
                   '(1 2 3 4)))

(test-equal "append of empty lists"
            '()
            (my-append '() '()))

(test-equal "append of empty and non-empty list"
            '(1 2 3 4)
            (my-append '() '(1 2 3 4)))

(test-equal "append of non-empty and empty list"
            '(1 2 3 4)
            (my-append '(1 2 3 4) '()))

(test-equal "append of non-empty lists"
            '(1 2 3 4 5)
            (my-append '(1 2 3) '(4 5)))

(test-equal "append of huge lists"
            (list-tabulate 2000000 values)
            (my-append (list-tabulate 1000000 values)
                       (list-tabulate 1000000 (lambda (x) (+ x 1000000)))))

(test-equal "concatenate of empty list of lists"
            '()
            (my-concatenate '()))

(test-equal "concatenate of normal list of lists"
            '(1 2 3 4 5 6)
            (my-concatenate '((1 2) (3) () (4 5 6))))

(test-equal "concatenate of huge list of small lists"
            (list-tabulate 1000000 values)
            (my-concatenate (list-tabulate 1000000 list)))

(test-equal "concatenate of small list of huge lists"
            (list-tabulate 1000000 values)
            (my-concatenate
             (list-tabulate 10 (lambda (i)
                                 (list-tabulate 100000
                                                (lambda (j) (+ (* 100000 i) j)))))))

(test-end "list-ops-test")
;;; End test suite
