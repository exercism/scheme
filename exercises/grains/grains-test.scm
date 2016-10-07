;; Load SRFI-64 lightweight testing specification
 (use-modules (srfi srfi-64))

 ;; Suppress log file output. To write logs, comment out the following line:
 (module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

 ;; Require module
 (add-to-load-path (dirname (current-filename)))
 (use-modules (grains))

 (test-begin "grains")

(test-eqv "square 1"
          1
          (square 1))

(test-eqv "square 2"
          2
          (square 2))

(test-eqv "square 3"
          4
          (square 3))

(test-eqv "square 4"
          8
          (square 4))

(test-eqv "square 16"
          32768
          (square 16))

(test-eqv "square 32"
          2147483648
          (square 32))

(test-eqv "square 64"
          9223372036854775808
          (square 64))

(test-eqv "total grains"
          18446744073709551615
          (total))

 ;; Tests go here

 (test-end "grains")
