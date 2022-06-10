(load "test-util.ss")

(define (matches? result expected)
  (let ([get-count (if (hashtable? result)
                       (lambda (word) (hashtable-ref result word 0))
                       (lambda (word)
                         (cond [(assoc word result) => cdr] [else 0])))])
    (and (= (length expected)
            (if (hashtable? result)
                (hashtable-size result)
                (length result)))
         (fold-left
           (lambda (count-agrees w.c)
             (and count-agrees (= (cdr w.c) (get-count (car w.c)))))
           #t
           expected))))

(define test-cases
  `((test-success "count one word" matches? word-count
      '("word") '(("word" . 1)))
     (test-success "count one of each word" matches? word-count
       '("one of each") '(("one" . 1) ("of" . 1) ("each" . 1)))
     (test-success "multiple occurrences of a word" matches? word-count
       '("one fish two fish red fish blue fish")
       '(("one" . 1)
          ("fish" . 4)
          ("two" . 1)
          ("red" . 1)
          ("blue" . 1)))
     (test-success "handles cramped lists" matches? word-count
       '("one,two,three") '(("one" . 1) ("two" . 1) ("three" . 1)))
     (test-success "handles expanded lists" matches? word-count
       '("one,\ntwo,\nthree")
       '(("one" . 1) ("two" . 1) ("three" . 1)))
     (test-success "ignore punctuation" matches? word-count
       '("car: carpet as java: javascript!!&@$%^&")
       '(("car" . 1)
          ("carpet" . 1)
          ("as" . 1)
          ("java" . 1)
          ("javascript" . 1)))
     (test-success "include numbers" matches? word-count
       '("testing, 1, 2 testing")
       '(("testing" . 2) ("1" . 1) ("2" . 1)))
     (test-success "normalize case" matches? word-count
       '("go Go GO Stop stop") '(("go" . 3) ("stop" . 2)))
     (test-success "with apostrophes" matches? word-count
       '("First: don't laugh. Then: don't cry.")
       '(("first" . 1)
          ("don't" . 2)
          ("laugh" . 1)
          ("then" . 1)
          ("cry" . 1)))
     (test-success "with quotations" matches? word-count
       '("Joe can't tell between 'large' and large.")
       '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1)
          ("large" . 2) ("and" . 1)))
     (test-success "substrings from the beginning" matches? word-count
       '("Joe can't tell between app, apple and a.")
       '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1)
          ("app" . 1) ("apple" . 1) ("and" . 1) ("a" . 1)))
     (test-success "multiple spaces not detected as a word" matches?
       word-count '(" multiple   whitespaces")
       '(("multiple" . 1) ("whitespaces" . 1)))
     (test-success "alternating word separators not detected as a word"
       matches? word-count '(",\n,one,\n ,two \n 'three'")
       '(("one" . 1) ("two" . 1) ("three" . 1)))))

(run-with-cli "word-count.scm" (list test-cases))

