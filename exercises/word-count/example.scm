(define-module (word-count)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 regex)
  #:export (countwords))


(define (countword word counters)
  (let* ((oldcount (assoc-ref counters word))
         (newcount (if oldcount (+ oldcount 1) 1)))
    (assoc-set! counters word newcount)))


(define (replace text pattern replacement)
  (regexp-substitute/global #f pattern text 'pre replacement 'post))


(define (normalize phrase)
  (let* ((nopuncts (replace phrase "[.,\n!&@%:^$]" " "))
         (onespace (replace nopuncts "[ ]+" " "))
         (endspace (replace onespace "[ ]+$" ""))
         (noquotes (replace endspace "( ')|(' )" " ")))
    (string-downcase noquotes)))


(define (countwords phrase)
  (fold countword '()
    (string-split (normalize phrase) #\space)))
