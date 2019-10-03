(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
                   equal?
                   two-fer
                   ,(let ((input (cdar (lookup 'input test))))
                      (if (null? input)
                          ''()
                          `'(,input)))
                   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec)))
       args))))

(let ((spec (get-test-specification 'two-fer)))
  (put-problem!
   'two-fer
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . ,"two-fer.scm")
     
     (solution . ,"example.scm")
     (hints.md
      .
      ,(md-hints
        `((sentence "One way to get optional arguments in scheme is by specifying the arguments as a list.")
          (sentence "Two ways to do that are: "
                    (inline-code "(define (two-fer . args) ...)")
                    " or "
                    (inline-code "(define two-fer (lambda args ...))")
                    ".")))))))

