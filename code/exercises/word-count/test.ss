(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 (lambda (result expected)
                   (let ((get-count (if (hashtable? result)
                                        (lambda (word)
                                          (hashtable-ref result word 0))
                                        (lambda (word)
                                          (cond ((assoc word result) => cdr)
                                                (else 0))))))
                     (and (= (length expected)
                             (hashtable-size result))
                          (fold-left (lambda (count-agrees w.c)
                                       (and count-agrees
                                            (= (cdr w.c)
                                               (get-count (car w.c)))))
                                     #t
                                     expected))))
                 word-count
                 '(,(cdar (lookup 'input test)))
                 '(,@(map (lambda (expected)
                            (cons (symbol->string (car expected))
                                  (cdr expected)))
                          (lookup 'expected test)))))

(let ((spec (get-test-specification 'word-count)))
  (put-problem!
   'word-count
   `((test . ,(map parse-test (lookup 'cases spec)))
     (stubs word-count)
     (version . ,(lookup 'version spec))
     (skeleton . "word-count.scm")
     (solution . "example.scm")
     (hints.md . ,(splice-exercism 'word-count)))))

