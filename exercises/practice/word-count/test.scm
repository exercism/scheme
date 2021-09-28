(import (except (rnrs) current-output-port))

(define test-fields '(input output))

(define (test-run-solution solution input)
  (if (procedure? solution) (apply solution input) solution))

(define (test-success description success-predicate
         procedure input output)
  (call/cc
    (lambda (k)
      (let ([out (open-output-string)])
        (with-exception-handler
          (lambda (e)
            (let ([result `(fail
                             (description . ,description)
                             (input . ,input)
                             (output . ,output)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              (k result)))
          (lambda ()
            (let ([result (parameterize ([current-output-port out])
                            (test-run-solution procedure input))])
              (unless (success-predicate result output)
                (error 'exercism-test
                  "test fails"
                  description
                  input
                  result
                  output)))
            (let ([result `(pass
                             (description . ,description)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              result)))))))

(define (test-error description procedure input)
  (call/cc
    (lambda (k)
      (let ([out (open-output-string)])
        (with-exception-handler
          (lambda (e)
            (let ([result `(pass
                             (description . ,description)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              (k result)))
          (lambda ()
            (parameterize ([current-output-port out])
              (test-run-solution procedure input))
            (let ([result `(fail
                             (description . ,description)
                             (input . ,input)
                             (output . error)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              result)))))))

(define (run-test-suite tests . query)
  (for-each
    (lambda (field)
      (unless (and (symbol? field) (memq field test-fields))
        (error 'run-test-suite
          (format #t "~a not in ~a" field test-fields))))
    query)
  (let-values ([(passes failures)
                (partition
                  (lambda (result) (eq? 'pass (car result)))
                  (map (lambda (test) (test)) tests))])
    (cond
      [(null? failures) (format #t "~%Well done!~%~%")]
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
                 (display "  - ")
                 (write (car info))
                 (display ": ")
                 (write (cdr info))
                 (newline)))
             query))
         failures)
       (error 'test "incorrect solution")])))

(define (run-docker test-cases)
  (write (map (lambda (test) (test)) test-cases)))

(define (matches? result expected)
  (let ([get-count (if (hashtable? result)
                     (lambda (word)
                       (hashtable-ref result word 0))
                     (lambda (word)
                       (cond
                         [(assoc word result) => cdr]
                         [else 0])))])
    (and (= (length expected)
            (if (hashtable? result) (hashtable-size result) (length result)))
         (fold-left
           (lambda (count-agrees w.c)
             (and count-agrees
                  (= (cdr w.c) (get-count (car w.c)))))
           #t
           expected))))

(define word-count)

(define test-cases
  (list
    (lambda ()
      (test-success "count one word" matches?
        word-count '("word") '(("word" . 1))))
    (lambda ()
      (test-success "count one of each word" matches?
        word-count '("one of each")
        '(("one" . 1) ("of" . 1) ("each" . 1))))
    (lambda ()
      (test-success "multiple occurrences of a word" matches?
        word-count '("one fish two fish red fish blue fish")
        '(("one" . 1)
           ("fish" . 4)
           ("two" . 1)
           ("red" . 1)
           ("blue" . 1))))
    (lambda ()
      (test-success "handles cramped lists" matches?
        word-count '("one,two,three")
        '(("one" . 1) ("two" . 1) ("three" . 1))))
    (lambda ()
      (test-success "handles expanded lists" matches?
        word-count '("one,\ntwo,\nthree")
        '(("one" . 1) ("two" . 1) ("three" . 1))))
    (lambda ()
      (test-success "ignore punctuation" matches?
        word-count '("car: carpet as java: javascript!!&@$%^&")
        '(("car" . 1)
           ("carpet" . 1)
           ("as" . 1)
           ("java" . 1)
           ("javascript" . 1))))
    (lambda ()
      (test-success "include numbers" matches?
        word-count '("testing, 1, 2 testing")
        '(("testing" . 2) ("1" . 1) ("2" . 1))))
    (lambda ()
      (test-success "normalize case" matches?
        word-count '("go Go GO Stop stop")
        '(("go" . 3) ("stop" . 2))))
    (lambda ()
      (test-success "with apostrophes" matches?
        word-count '("First: don't laugh. Then: don't cry.")
        '(("first" . 1)
           ("don't" . 2)
           ("laugh" . 1)
           ("then" . 1)
           ("cry" . 1))))
    (lambda ()
      (test-success "with quotations" matches?
          word-count '("Joe can't tell between 'large' and large.")
        '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1)
           ("large" . 2) ("and" . 1))))
    (lambda ()
      (test-success "substrings from the beginning" matches?
        word-count '("Joe can't tell between app, apple and a.")
        '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1)
           ("app" . 1) ("apple" . 1) ("and" . 1) ("a" . 1))))
    (lambda ()
      (test-success "multiple spaces not detected as a word" matches?
        word-count '(" multiple   whitespaces")
        '(("multiple" . 1) ("whitespaces" . 1))))
    (lambda ()
      (test-success "alternating word separators not detected as a word" matches?
        word-count '(",\n,one,\n ,two \n 'three'")
        '(("one" . 1) ("two" . 1) ("three" . 1))))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "word-count.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "word-count.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))
