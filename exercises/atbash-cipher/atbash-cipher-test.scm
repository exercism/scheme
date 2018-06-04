;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require module
(add-to-load-path (dirname (current-filename)))
(use-modules (atbash-cipher))

(test-begin "atbash-cipher")

;; Tests go here

(test-equal "'yes' encoded is 'bvh'."
  "bvh"
  (encode "yes"))

(test-equal "'no' encoded is 'ml'."
  "ml"
  (encode "no"))

(test-equal "Encoding always returns lower-case letters."
  "lnt"
  (encode "OMG"))

(test-equal "Encoding removes spaces from input."
  "lnt"
  (encode "O M G"))

(test-equal "Encoded output includes a space every five characters."
  "nrmwy oldrm tob"
  (encode "mindblowingly"))

(test-equal "Symbols are ignored, and numbers are passed-through unmodified"
  "gvhgr mt123 gvhgr mt"
  (encode "Testing,1 2 3, Testing."))

(test-equal "Deep thoughts can be encoded"
  "gifgs rhurx grlm"
  (encode "Truth is fiction."))

(test-equal "Every lowercase less has an encoding"
  "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
  (encode "The quick brown fox jumps over the lazy dog."))

(test-equal "Unicode-range symbols are ignored"
  "mlmzh xrrrt mlivw"
  (encode "non ascii éignored"))

(test-equal "Exercism can be decoded"
  "exercism"
  (decode "vcvix rhn"))

(test-equal "Decodes a sentence"
  "anobstacleisoftenasteppingstone"
  (decode "zmlyh gzxov rhlug vmzhg vkkrm thglm v"))

(test-equal "Decoding ignores symbols and passes-through numbers just like encoding"
  "testing123testing"
  (decode "gvhgr mt123 gvhgr mt"))

(test-equal "Every lowercase letter can be decoded"
  "thequickbrownfoxjumpsoverthelazydog"
  (decode "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"))

(test-end "atbash-cipher")
