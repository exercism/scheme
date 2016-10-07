;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

(add-to-load-path (dirname (current-filename)))

(use-modules (raindrops))

(test-begin "raindrops")

(test-equal "test-1"
            "1"
            (convert 1))

(test-equal "test-3"
            "Pling"
            (convert 3))

(test-equal "test-5"
            "Plang"
            (convert 5))

(test-equal "test-7"
            "Plong"
            (convert 7))
(test-equal "test-6"
            "Pling"
            (convert 6))
(test-equal "test-9"
            "Pling"
            (convert 9))
(test-equal "test-10"
            "Plang"
            (convert 10))
(test-equal "test-15"
            "PlingPlang"
            (convert 15))
(test-equal "test-21"
            "PlingPlong"
            (convert 21))
(test-equal "test-25"
            "Plang"
            (convert 25))
(test-equal "test-35"
            "PlangPlong"
            (convert 35))
(test-equal "test-49"
            "Plong"
            (convert 49))
(test-equal "test-52"
            "52"
            (convert 52))
(test-equal "test-105"
            "PlingPlangPlong"
            (convert 105))
(test-equal "test-12121"
            "12121"
            (convert 12121))


(test-end "raindrops")
