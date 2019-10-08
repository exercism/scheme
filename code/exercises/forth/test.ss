
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
                       '(,@expected)))))

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
     (markdown . ,(splice-exercism 'forth)))))

