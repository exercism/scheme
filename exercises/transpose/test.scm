(define test-fields '(input output who))

(define (test-run-solution solution input)
  (if (procedure? solution) (apply solution input) solution))

(define (test-success description success-predicate
         procedure input output)
  (call/cc
    (lambda (k)
      (with-exception-handler
        (lambda (e)
          (k `(fail
                (description . ,description)
                (input . ,input)
                (output . ,output)
                (who . ,procedure))))
        (lambda ()
          (let ([result (test-run-solution procedure input)])
            (unless (success-predicate result output)
              (error 'exercism-test
                "test fails"
                description
                input
                result
                output)))
          `(pass . ,description))))))

(define (test-error description procedure input)
  (call/cc
    (lambda (k)
      (with-exception-handler
        (lambda (e) (k `(pass . ,description)))
        (lambda ()
          (test-run-solution procedure input)
          `(fail
             (description . ,description)
             (input . ,input)
             (output . error)
             (who . ,procedure)))))))

(define (run-test-suite tests . query)
  (for-each
    (lambda (field)
      (unless (and (symbol? field) (memq field test-fields))
        (error 'run-test-suite
          (format "~a not in ~a" field test-fields))))
    query)
  (let-values ([(passes failures)
                (partition
                  (lambda (result) (eq? 'pass (car result)))
                  (map (lambda (test) (test)) tests))])
    (cond
      [(null? failures) (format #t "~%Well done!~%~%") 'success]
      [else
       (format
         #t
         "~%Passed ~a/~a tests.~%~%The following test cases failed:~%~%"
         (length passes)
         (length tests))
       (for-each
         (lambda (failure)
           (format
             #t
             "* ~a~%"
             (cond
               [(assoc 'description (cdr failure)) => cdr]
               [else (cdr failure)]))
           (for-each
             (lambda (field)
               (let ([info (assoc field (cdr failure))])
                 (format #t "  - ~a: ~a~%" (car info) (cdr info))))
             query))
         failures)
       (newline)
       'failure])))

(define (test . args)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "empty string" equal? transpose '(()) '()))
      (lambda ()
        (test-success "two characters in a row" equal? transpose
          '(("A1")) '("A" "1")))
      (lambda ()
        (test-success "two characters in a column" equal? transpose
          '(("A" "1")) '("A1")))
      (lambda ()
        (test-success "simple" equal? transpose '(("ABC" "123"))
          '("A1" "B2" "C3")))
      (lambda ()
        (test-success "single line" equal? transpose '(("Single line."))
          '("S" "i" "n" "g" "l" "e" " " "l" "i" "n" "e" ".")))
      (lambda ()
        (test-success "first line longer than second line" equal? transpose
          '(("The fourth line." "The fifth line. "))
          '("TT" "hh" "ee" "  " "ff" "oi" "uf" "rt" "th" "h " " l"
             "li" "in" "ne" "e." ". ")))
      (lambda ()
        (test-success "second line longer than first line" equal? transpose
          '(("The first line. " "The second line."))
          '("TT" "hh" "ee" "  " "fs" "ie" "rc" "so" "tn" " d" "l "
             "il" "ni" "en" ".e" " .")))
      (lambda ()
        (test-success "mixed line length" equal? transpose
          '(("The longest line."
              "A long line.     "
              "A longer line.   "
              "A line.          "))
          '("TAAA" "h   " "elll" " ooi" "lnnn" "ogge" "n e." "glr "
             "ei  " "snl " "tei " " .n " "l e " "i . " "n   " "e   "
             ".   ")))
      (lambda ()
        (test-success "square" equal? transpose
          '(("HEART" "EMBER" "ABUSE" "RESIN" "TREND"))
          '("HEART" "EMBER" "ABUSE" "RESIN" "TREND")))
      (lambda ()
        (test-success "rectangle" equal? transpose
          '(("FRACTURE" "OUTLINED" "BLOOMING" "SEPTETTE"))
          '("FOBS" "RULE" "ATOP" "CLOT" "TIME" "UNIT" "RENT" "EDGE")))
      (lambda ()
        (test-success "triangle" equal? transpose
          '(("T     " "EE    " "AAA   " "SSSS  " "EEEEE " "RRRRRR"))
          '("TEASER" " EASER" "  ASER" "   SER" "    ER" "     R"))))
    args))

