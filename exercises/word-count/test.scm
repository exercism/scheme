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
          (test-run-scheme procedure input)
          `(fail
             (description . ,description)
             (input . ,input)
             (output . ,output)
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

(define (count-equal? result expected)
  (let ([get-count (if (hashtable? result)
                       (lambda (word) (hashtable-ref result word 0))
                       (lambda (word)
                         (cond [(assoc word result) => cdr] [else 0])))])
    (and (= (length expected) (hashtable-size result))
         (fold-left
           (lambda (count-agrees w.c)
             (and count-agrees (= (cdr w.c) (get-count (car w.c)))))
           #t
           expected))))

(define (test . args)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "count one word" count-equal? word-count
          '("word") '(("word" . 1))))
      (lambda ()
        (test-success "count one of each word" count-equal? word-count
          '("one of each") '(("one" . 1) ("of" . 1) ("each" . 1))))
      (lambda ()
        (test-success "multiple occurrences of a word" count-equal? word-count
          '("one fish two fish red fish blue fish")
          '(("one" . 1)
             ("fish" . 4)
             ("two" . 1)
             ("red" . 1)
             ("blue" . 1))))
      (lambda ()
        (test-success "handles cramped lists" count-equal? word-count
          '("one,two,three")
          '(("one" . 1) ("two" . 1) ("three" . 1))))
      (lambda ()
        (test-success "handles expanded lists" count-equal? word-count
          '("one,\ntwo,\nthree")
          '(("one" . 1) ("two" . 1) ("three" . 1))))
      (lambda ()
        (test-success "ignore punctuation" count-equal? word-count
          '("car: carpet as java: javascript!!&@$%^&")
          '(("car" . 1)
             ("carpet" . 1)
             ("as" . 1)
             ("java" . 1)
             ("javascript" . 1))))
      (lambda ()
        (test-success "include numbers" count-equal? word-count
          '("testing, 1, 2 testing")
          '(("testing" . 2) ("1" . 1) ("2" . 1))))
      (lambda ()
        (test-success "normalize case" count-equal? word-count
          '("go Go GO Stop stop") '(("go" . 3) ("stop" . 2))))
      (lambda ()
        (test-success "with apostrophes" count-equal? word-count
          '("First: don't laugh. Then: don't cry.")
          '(("first" . 1)
             ("don't" . 2)
             ("laugh" . 1)
             ("then" . 1)
             ("cry" . 1))))
      (lambda ()
        (test-success "with quotations" count-equal? word-count
          '("Joe can't tell between 'large' and large.")
          '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1)
             ("large" . 2) ("and" . 1))))
      (lambda ()
        (test-success "substrings from the beginning" count-equal? word-count
          '("Joe can't tell between app, apple and a.")
          '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1)
             ("app" . 1) ("apple" . 1) ("and" . 1) ("a" . 1))))
      (lambda ()
        (test-success "multiple spaces not detected as a word" count-equal?
          word-count '(" multiple   whitespaces")
          '(("multiple" . 1) ("whitespaces" . 1))))
      (lambda ()
        (test-success "alternating word separators not detected as a word"
          count-equal? word-count '(",\n,one,\n ,two \n 'three'")
          '(("one" . 1) ("two" . 1) ("three" . 1)))))
    args))

