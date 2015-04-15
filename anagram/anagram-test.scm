;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require module
(add-to-load-path (dirname (current-filename)))
(use-modules (anagram))

(test-begin "anagram")

;; Tests go here

(test-equal "no-matches"
            '()
            (anagrams-for
             "diaper"
             '("hello" "world" "zombies" "pants")))

(test-equal "detect simple anagram"
            '("tan")
            (anagrams-for "ant" '("tan" "stand" "at")))

(test-equal "does not confuse different duplicates"
            '()
            (anagrams-for "galea" '("eagle")))

(test-equal "eliminate anagram subsets"
            '()
            (anagrams-for "good" '("dog" "goody")))

(test-equal "detect anagram"
            '("inlets")
            (anagrams-for
             "listen"
             '("enlists" "google" "inlets" "banana")))

(test-equal "multiple-anagrams"
            '("gallery" "regally" "largely")
            (anagrams-for
             "allergy"
             '("gallery" "ballerina" "regally" "clergy" "largely" "leading")))

(test-equal "case-insensitive-anagrams"
            '("Carthorse")
            (anagrams-for
             "Orchestra"
             '("cashregister" "Carthorse" "radishes")))

(test-equal "word is not own anagram"
            '()
            (anagrams-for "banana" '("banana")))

(test-end "anagram")
