(define (parse-test test)
  (let ((expected (lookup 'expected test))
        (input (lookup 'input test)))
    (if (or (null? expected)
            (number? (car expected)))
        `(lambda ()
           (test-success ,(lookup 'description test)
                         (lambda (out expected)
                           (equal? (list-sort < out) (list-sort < expected)))
                         change
                         '(,(lookup 'target input)
                           ,(lookup 'coins input))
                         ',expected))
        `(lambda ()
           (test-error ,(lookup 'description test)
                       change
                       '(,(lookup 'target input)
                         ,(lookup 'coins input)))))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec)))
       args))))

(let ((spec (get-test-specification 'change)))
  (put-problem!
   'change
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "change.scm")
     (solution . "example.scm"))))

