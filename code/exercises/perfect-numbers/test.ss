(define (parse-test test)
  (let ((expected (lookup 'expected test)))
    (if (pair? expected)
        `(test-error ,(lookup 'description test)
                     classify
                     '(,(cdar (lookup 'input test))))
        `(test-success ,(lookup 'description test)
                       eq?
                       classify
                       '(,(cdar (lookup 'input test)))
                       ',(string->symbol expected)))))

(define (spec->tests spec)
  (map parse-test
       (apply append
              (map (lookup-partial 'cases)
                   (lookup 'cases spec)))))

(let ((spec (get-test-specification 'perfect-numbers)))
  (put-problem!
   'perfect-numbers
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (stubs classify)
     (skeleton . "perfect-numbers.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism 'perfect-numbers)))))

