(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 eq?
                 attacking?
                 '(,@(map (lambda (queen)
                            (map cdr (cdadr queen)))
                          (lookup 'input test)))
                 ,(lookup 'expected test)))

(define (spec->tests spec)
  ;; boo to error cases
  (lookup 'cases
          (cadr
           (lookup 'cases
                   (get-test-specification 'queen-attack)))))

(let ([spec (get-test-specification 'queen-attack)])
  (put-problem!
   'queen-attack
   `((test . ,(map parse-test (spec->tests spec)))
     (stubs attacking?)
     (version . ,(lookup 'version spec))
     (skeleton . "queen-attack.scm")
     (solution . "example.scm")
     (markdown
      .
      ,(splice-exercism
        'queen-attack
        
        '((sentence "For this track, each queen's position will be represented as a list
containing the row and the column.")
          (sentence "You should assume all inputs are valid, there's no need to report errors.")))))))

