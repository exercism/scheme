;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require module
(add-to-load-path (dirname (current-filename)))
(use-modules (two-fer))

(test-begin "two-fer")

(test-assert "no name given"
             (equal? (two-fer)
                     "One for you, one for me."))

(test-assert "a name given"
             (equal? (two-fer "Alice")
                     "One for Alice, one for me."))

(test-assert "another name given"
             (equal? (two-fer "Bob")
                     "One for Bob, one for me."))

(test-end "two-fer")
