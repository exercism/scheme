; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/word-count/canonical-data.json
; File last updated on 2026-10-21T17:55:21+00:00

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
  `(
    (test-success "1. count one word" matches? word-count '("word")
        '(("word" . 1)))

    (test-success "2. count one of each word" matches? word-count '("one of each")
        '(("one" . 1) ("of" . 1) ("each" . 1)))

    (test-success "3. multiple occurrences of a word" matches? word-count '("one fish two fish red fish blue fish")
        '(("one" . 1) ("fish" . 4) ("two" . 1) ("red" . 1) ("blue" . 1)))

    (test-success "4. handles cramped lists" matches? word-count '("one,two,three")
        '(("one" . 1) ("two" . 1) ("three" . 1)))

    (test-success "5. handles expanded lists" matches? word-count '("one,\ntwo,\nthree")
        '(("one" . 1) ("two" . 1) ("three" . 1)))

    (test-success "6. ignore punctuation" matches? word-count '("car: carpet as java: javascript!!&@$%^&")
        '(("car" . 1) ("carpet" . 1) ("as" . 1) ("java" . 1) ("javascript" . 1)))

    (test-success "7. include numbers" matches? word-count '("testing, 1, 2 testing")
        '(("testing" . 2) ("1" . 1) ("2" . 1)))

    (test-success "8. normalize case" matches? word-count '("go Go GO Stop stop")
        '(("go" . 3) ("stop" . 2)))

    (test-success "9. with apostrophes" matches? word-count '("'First: don't laugh. Then: don't cry. You're getting it.'")
        '(("first" . 1) ("don't" . 2) ("laugh" . 1) ("then" . 1) ("cry" . 1) ("you're" . 1) ("getting" . 1) ("it" . 1)))

    (test-success "10. with quotations" matches? word-count '("Joe can't tell between 'large' and large.")
        '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1) ("large" . 2) ("and" . 1)))

    (test-success "11. substrings from the beginning" matches? word-count '("Joe can't tell between app, apple and a.")
        '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1) ("app" . 1) ("apple" . 1) ("and" . 1) ("a" . 1)))

    (test-success "12. multiple spaces not detected as a word" matches? word-count '(" multiple   whitespaces")
        '(("multiple" . 1) ("whitespaces" . 1)))

    (test-success "13. alternating word separators not detected as a word" matches? word-count '(",\n,one,\n ,two \n 'three'")
        '(("one" . 1) ("two" . 1) ("three" . 1)))

    (test-success "14. quotation for word with apostrophe" matches? word-count '("can, can't, 'can't'")
        '(("can" . 1) ("can't" . 2)))
    ))

(run-with-cli "word-count.scm" (list test-cases))
