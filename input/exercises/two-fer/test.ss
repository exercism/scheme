(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 equal?
                 two-fer
                 ,(let ((input (cdar (lookup 'input test))))
                    (if (null? input)
                        ''()
                        `'(,input)))
                 ,(lookup 'expected test)))

(let ((spec (get-test-specification 'two-fer)))
  (put-problem!
   'two-fer
   `((test . ,(map parse-test (lookup 'cases spec)))
     (stubs two-fer)
     (version . ,(lookup 'version spec))
     (skeleton . "two-fer.scm")
     (solution . "example.scm")
     (markdown
      .
      ,(splice-exercism
        'two-fer
        '((sentence "One way to get optional arguments in scheme is by specifying the arguments as a list.")
          (sentence "Two ways to do that are: "
                    (inline-code "(define (two-fer . args) ...)")
                    " or "
                    (inline-code "(define two-fer (lambda args ...))")
                    ".")))))))

