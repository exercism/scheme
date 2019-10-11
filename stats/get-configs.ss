(import (chezscheme)
        (json)
        (srfi :1))

;; hard coded list which can be gotten from (read-tracks)
(define *tracks*
  '(x86-64-assembly
    vimscript typescript swift sml scheme scala
    rust ruby reasonml racket r python purescript prolog plsql
    php pharo-smalltalk perl6 perl5 ocaml objective-c nim mips
    lua lfe kotlin julia javascript java haskell groovy go
    fsharp erlang elisp elm elixir delphi dart d crystal
    common-lisp coffeescript clojure cfml cpp csharp c bash
    ballerina))

(define tracks-file
  "tracks.txt")

(define (read-tracks)
  (with-input-from-file tracks-file
    (lambda ()
      (let loop ((curr (read)) (tracks '()))
        (if (eof-object? curr)
            tracks
            (loop (read) (cons curr tracks)))))))

(define (download-config track)
  (let ((config.json (format "~a.json" track)))
    (system (format "wget https://raw.githubusercontent.com/exercism/~a/master/config.json -O ~a" track config.json))))

(define (get-config track)
  (let ((config.json (format "~a.json" track)))
    (unless (file-exists? config.json)
      (download-config track))
    (with-input-from-file config.json json-read)))

(define (save-fasl obj file)
  (let ((out (open-file-output-port file)))
    (fasl-write obj out)
    (close-output-port out)))

(define (fasl-load file)
  (let ((in (open-file-input-port file)))
    (let ((obj (fasl-read in)))
      (close-input-port in)
      obj)))

(define (*configs*)
  (map (lambda (track)
         (cons (cons 'language track)
               (cdr (get-config track))))
       (read-tracks)))

(define (get-configs)
  (fasl-load "configs.fasl"))

(define lookup
  (case-lambda
    ((symbol)
     (lambda (thing)
       (lookup symbol thing)))
    ((symbol thing)
     (cond ((assoc symbol thing)
            => cdr)))
    ((default symbol thing)
     (cond ((assoc symbol thing)
            => cdr)
           (else default)))))

(define (rate-difficulty lo hi x)
  (and (< 1 hi)
       (not (= lo hi))
       (/ (- x lo)
          (- hi lo))))

(define (rate-controversy problem)
  (let ((ratings (map caddr (lookup-problem problem))))
    (- (apply max ratings)
       (apply min ratings))))

(define difficulty-table
  (map (lambda (track)
         (let* ((exs (lookup 'exercises track))
                (diffs (filter number?
                               (map (lambda (ex)
                                      (lookup 'difficulty ex))
                                    exs)))
                (lo (apply min diffs))
                (hi (apply max diffs)))
           `(,(cdar track)
             ,@(filter (lambda (x) x)
                       (map (lambda (ex)
                              (cons (string->symbol (lookup 'slug ex))
                                    ;;                                    (lookup 'difficulty ex)
                                    ;;
                                    (rate-difficulty lo hi (lookup 'difficulty ex))
                                    ))
                            exs)))))
       (get-configs)))

(define (square x)
  (* x x))

(define (avg data)
  (cons (length data)
        (/ (fold-left + 0 (cons 0. data))
           (length data))))

(define problem-table
  (filter caddr
          (apply append
                 (map (lambda (track)
                        (let ((lang (car track)))
                          (map (lambda (rating)
                                 `(,(car rating) ,lang ,(cdr rating)))
                               (cdr track))))
                      difficulty-table))))

(define (sort-on heuristic)
  (lambda (xs)
    (sort (lambda (x y)
            (> (heuristic x)
               (heuristic y)))
          xs)))

(define (lookup-problem problem)
  (filter (lambda (x)
            (eq? (car x) problem))
          problem-table))

(define (rate-problem problem)
  (cons problem
        (avg (filter number?
                     (map (lambda (lang)
                            (lookup problem (cdr lang)))
                          difficulty-table)))))

(define problem-list
  (map rate-problem 
       (delete-duplicates
        (apply append
               (map (lambda (lang)
                      (map car (cdr lang)))
                    difficulty-table)))))

(define problem-names
  (map car problem-list))

(define (describe-avg problem data)
  (let ((n (length data)))
    (format #t "problem: ~a~%rating : ~,3f~%samples: ~a~%range: ~,3f~%"
            problem
            (/ (apply + data) n)
            n
            (- (apply max data)
               (apply min data)))))


(define (describe-problem problem)
  (describe-avg problem
                (map caddr (lookup-problem problem))))

(define (write-problems)
  (for-each (lambda (problem)
              ;; ignore unpopular problem
              (when (< 2 (cadr problem))
                (format #t "~a ~a ~a~%"
                        (cadr problem)
                        (cddr problem)
                        (car problem))))
            problem-list))

(define difficult-problems
  (list-head
   (filter (lambda (p)
             (> (cadr p) 3))
           (sort (lambda (x y)
                   (> (cddr x)
                      (cddr y)))
                 problem-list))
   20))

(define popular-problems
  (list-head (filter (lambda (p)
                       (> (cadr p) 3))
                     (sort (lambda (x y)
                             (> (cadr x)
                                (cadr y)))
                           problem-list))
             20))

(define (chart-track track)
  (for-each (lambda (problem)
              ;; ignore unpopular problem
              (when (< 2 (cadr problem))
                (format #t "~a ~a ~a~%"
                        (cadr problem)
                        (cddr problem)
                        (car problem))))
            (map rate-problem
                 (map string->symbol
                      (map (lookup 'slug)
                           (lookup 'exercises
                                   (get-config track)))))))

(define (compare-langs l1 l2)
  (let ((opinion1 (cdr (assq l1 difficulty-table)))
        (opinion2 (cdr (assq l2 difficulty-table))))
    (let ((matches (filter number?
                           (map (lambda (o2)
                                  (cond ((assq (car o2) opinion1)
                                         => (lambda (o1)
                                              (and (number? (cdr o2))
                                                   (number? (cdr o1))
                                                   (abs (- (cdr o2) (cdr o1))))))
                                        (else #f)))
                                opinion2))))
      (avg matches))))

(define popular-languages
  (filter symbol?
          (map (lambda (track)
                 (cond ((assq track difficulty-table)
                        => (lambda (x)
                             (and (< 20 (length (cdr x)))
                                  (car x))))
                       (else #f)))
               *tracks*)))

(define (similar-languages langs)
  (let ((comparisons (let l1 ((ls langs))
                       (let ((a (car ls)))
                         (if (null? (cdr ls))
                             '()
                             (let l2 ((ns (cdr ls)))
                               (if (null? ns)
                                   (l1 (cdr ls))
                                   (cons (list a (car ns) (compare-langs a (car ns)))
                                         (l2 (cdr ns))))))))))
    ((sort-on cdaddr)
     (filter (lambda (cmp)
               (and (< (cdaddr cmp) 10)
                    (< 10 (caaddr cmp))))
             comparisons))))

(define (partners lang)
  ((sort-on cdr)
   (map (lambda (o)
          (cons (car o) (cddr o)))
        (filter (lambda (xy)
                  (and (not (nan? (cddr xy)))
                       (< 2 (cadr xy))))
                (map (lambda (track)
                       (cons track
                             (compare-langs track lang)))
                     *tracks*)))))

(define (dot-graph langs)
  (define (escape node)
    (list->string
     (map (lambda (x)
            (if (char=? x #\-)
                #\_
                x))
          (string->list
           (symbol->string node)))))
  (let ((dot "exercism.dot"))
    (when (file-exists? dot)
      (delete-file dot))
    (with-output-to-file dot
      (lambda ()
        (display "graph G {")
        (display "node [fontsize=7,height=0.2,shape=\"circle\",style=\"filled\"];")
        (display "edge [len=3,style=\"invisible\",color=\"white\"];")
        (for-each (lambda (e)
                    (apply format #t "~a -- ~a [weight=~,2f];" e))
                  (map (lambda (x)
                         `(,@(map escape (list-head x 2))
                           ,(square (square (- 1 (cdaddr x))))))
                       (similar-languages langs)))
        (display "}\n")))))

