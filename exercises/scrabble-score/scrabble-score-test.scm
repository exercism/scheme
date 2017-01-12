;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require module
(add-to-load-path (dirname (current-filename)))
(use-modules (scrabble-score))

(test-begin "hello-world")

(test-assert "a is worth one point"
             (equal? (score "a")
                     1))

(test-assert "scoring is case insensitive"
             (equal? (score "A")
                     1))

(test-assert "f is worth four"
             (equal? (score "f")
                     4))

(test-assert "two one point letters make a two point word"
             (equal? (score "at")
                     2))

(test-assert "three letter word"
             (equal? (score "zoo")
                     12))

(test-assert "medium word"
             (equal? (score "street")
                     6))

(test-assert "longer words with valuable letters"
             (equal? (score "quirky")
                     22))

(test-assert "long mixed case word"
             (equal? (score "OxyphenButazone")
                     41))

(test-assert "english scrabble letters score"
             (equal? (score "pinata")
                     8))

(test-assert "non english scrabble letters do not score"
             (equal? (score "piñata")
                     7))

(test-assert "empty words are worth zero"
             (equal? (score "")
                     0))

(test-end "hello-world")
