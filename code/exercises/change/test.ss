(define (parse-test test)
  (let ((expected (lookup 'expected test))
        (input (lookup 'input test)))
    (if (or (null? expected)
            (number? (car expected)))
        `(test-success ,(lookup 'description test)
                       (lambda (out expected)
                         (equal? (list-sort < out) (list-sort < expected)))
                       change
                       '(,(lookup 'target input)
                         ,(lookup 'coins input))
                       ',expected)
        `(test-error ,(lookup 'description test)
                     change
                     '(,(lookup 'target input)
                       ,(lookup 'coins input))))))

(define (spec->tests spec)
  (map parse-test (lookup 'cases spec)))

(let ((spec (get-test-specification 'change)))
  (put-problem!
   'change
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "change.scm")
     (solution . "example.scm")
     (stubs change)
     (hints.md . ,(splice-exercism 'change)))))

