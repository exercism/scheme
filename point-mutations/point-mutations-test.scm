;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

(add-to-load-path (dirname (current-filename)))
(use-modules (point-mutations))

(test-begin "point-mutations")

(test-eqv "no-difference-between-empty-strands"
          0
          (hamming-distance "" ""))

(test-eqv "no-difference-between-identical-strands"
          0
          (hamming-distance "GATTACA" "GATTACA"))

(test-eqv "complete-hamming-distance-in-small-strand"
          3
          (hamming-distance "ACT" "GGA"))

(test-eqv "small-hamming-distance-in-middle-somewhere"
          1
          (hamming-distance "GGACG" "GGTCG"))

(test-eqv "larger-difference"
          2
          (hamming-distance "ACCAGGG" "ACTATGG"))

(test-error "invalid-to-get-distance-for-different-length-strings"
         #t
         (hamming-distance "AGACAACAGCCAGCCGCCGGATT" "AGGCAA"))


(test-end "point-mutations")
