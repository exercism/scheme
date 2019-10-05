(define (parse-test test)
  (let ((input (cdar (lookup 'input test))))
    `(test-success ,(lookup 'description test)
                   eq?
                   pangram?
                   '(,input)
                   ,(lookup 'expected test))))

(let ([spec (get-test-specification 'pangram)])
  (put-problem!
   'pangram
   `((test . ,(map parse-test (lookup 'cases spec)))
     (stubs pangram?)
     (version . ,(lookup 'version spec))
     (skeleton . "pangram.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism 'pangram
                                   '(sentence
                                     "Consider inputs case insensitive
and allow more than one of each required char."))))))

