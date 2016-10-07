;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require module
(add-to-load-path (dirname (current-filename)))
(use-modules (squares))

(test-begin "difference-of-squares")

(test-eqv "square-of-sums-to-5"
          225
          (square-of-sums 5))
(test-eqv "sum-of-squares-to-5"
          55
          (sum-of-squares 5))
(test-eqv "difference of-sums-to-5"
          170
          (difference 5))

(test-eqv "square-of-sums-to-10"
          3025
          (square-of-sums 10))
(test-eqv "sum-of-squares-to-10"
          385
          (sum-of-squares 10))
(test-eqv "difference of-sums-to-10"
          2640
          (difference 10))

(test-eqv "square-of-sums-to-100"
          25502500
          (square-of-sums 100))
(test-eqv "sum-of-squares-to-100"
          338350
          (sum-of-squares 100))
(test-eqv "difference of-sums-to-100"
          25164150
          (difference 100))



(test-end "difference-of-squares")
