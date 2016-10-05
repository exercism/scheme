;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require module
(add-to-load-path (dirname (current-filename)))
(use-modules (leap-year))

(test-begin "leap-year")

(test-eqv "vanilla-leap-year"
          #t
          (leap-year? 1996))

(test-eqv "any-old-year"
          #f
          (leap-year? 1997))

(test-eqv "non-leap-even-year"
          #f
          (leap-year? 1998))

(test-eqv "century"
          #f
          (leap-year? 1900))

(test-eqv "exceptional-century"
          #t
          (leap-year? 2400))

(test-end "leap-year")
