
(define (parse-test test)
  (let ((expected (lookup 'expected test)))
    (if (and (pair? expected)
             (pair? (car expected))
             (eq? 'error (caar expected)))
        `(test-error ,(lookup 'description test)
                     forth
                     '(,(cdar (lookup 'input test))))
        `(test-success ,(lookup 'description test)
                       equal?
                       forth
                       '(,(cdar (lookup 'input test)))
                       '(,@(reverse expected))))))

(define (spec->tests spec)
  (map parse-test
       (apply append
              (map (lookup-partial 'cases)
                   (lookup 'cases
                           (get-test-specification 'forth))))))

(let ([spec (get-test-specification 'forth)])
  (put-problem!
   'forth
   `((test . ,(spec->tests spec))
     (stubs forth)
     (version . ,(lookup 'version spec))
     (skeleton . "forth.scm")
     (solution . "example.scm")
     (markdown
      .
      ,(splice-exercism
        'forth
        '((sentence "The input is presented as a list of strings.")
          (sentence "Definitions are presented as "
                    (inline-code ": var x ... ;")
                    " where "
                    (inline-code "var")
                    " is bound to what follows.")
          (sentence "Otherwise the string represents a sequence of stack manipulations.")))))))

