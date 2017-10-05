;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require module
(add-to-load-path (dirname (current-filename)))
(use-modules (word-count))

;; Tests for countwords
(test-begin "countwords")


(test-equal "count one word"
  (assoc-ref (countwords "word") "word") 1)


(test-assert "count one of each word"
  (let ((result (countwords "one of each")))
    (and (equal? (assoc-ref result "one") 1)
         (equal? (assoc-ref result "of") 1)
         (equal? (assoc-ref result "each") 1))))


(test-assert "multiple occurrences of a word"
  (let ((result (countwords "one fish two fish red fish blue fish")))
    (and (equal? (assoc-ref result "one") 1)
         (equal? (assoc-ref result "fish") 4)
         (equal? (assoc-ref result "two") 1)
         (equal? (assoc-ref result "red") 1)
         (equal? (assoc-ref result "blue") 1))))


(test-assert "handles cramped lists"
  (let ((result (countwords "one,two,three")))
    (and (equal? (assoc-ref result "one") 1)
         (equal? (assoc-ref result "two") 1)
         (equal? (assoc-ref result "three") 1))))


(test-assert "handles expanded lists"
  (let ((result (countwords "one,\ntwo,\nthree")))
    (and (equal? (assoc-ref result "one") 1)
         (equal? (assoc-ref result "two") 1)
         (equal? (assoc-ref result "three") 1))))


(test-assert "ignore punctuation"
  (let ((result (countwords "car: carpet as java: javascript!!&@$%^&")))
    (and (equal? (assoc-ref result "car") 1)
         (equal? (assoc-ref result "carpet") 1)
         (equal? (assoc-ref result "as") 1)
         (equal? (assoc-ref result "java") 1)
         (equal? (assoc-ref result "javascript") 1))))


(test-assert "include numbers"
  (let ((result (countwords "testing, 1, 2 testing")))
    (and (equal? (assoc-ref result "testing") 2)
         (equal? (assoc-ref result "1") 1)
         (equal? (assoc-ref result "2") 1))))


(test-assert "normalize case"
  (let ((result (countwords "go Go GO Stop stop")))
    (and (equal? (assoc-ref result "go") 3)
         (equal? (assoc-ref result "stop") 2))))


(test-assert "with apostrophes"
  (let ((result (countwords "First: don't laugh. Then: don't cry.")))
    (and (equal? (assoc-ref result "first") 1)
         (equal? (assoc-ref result "don't") 2)
         (equal? (assoc-ref result "laugh") 1)
         (equal? (assoc-ref result "then") 1)
         (equal? (assoc-ref result "cry") 1))))


(test-assert "with quotations"
  (let ((result (countwords "Joe can't tell between 'large' and large.")))
    (and (equal? (assoc-ref result "joe") 1)
         (equal? (assoc-ref result "can't") 1)
         (equal? (assoc-ref result "tell") 1)
         (equal? (assoc-ref result "between") 1)
         (equal? (assoc-ref result "large") 2)
         (equal? (assoc-ref result "and") 1))))


(test-end "countwords")
