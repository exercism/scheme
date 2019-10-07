(define (parse-output expecting)
  (if (number? expecting)
      expecting
      ''not-found))

(define (parse-test test)
  (let ((input (lookup 'input test)))
    `(test-success ,(lookup 'description test)
                   equal?
                   binary-search
                   '(,(list->vector
                       (lookup 'array input))
                     ,(lookup 'value input))
                   ,(parse-output (lookup 'expected test)))))

(define (spec->tests spec)
  (map parse-test (lookup 'cases spec)))

(let ([spec (get-test-specification 'binary-search)])
  (put-problem!
   'binary-search
   `((test . ,(spec->tests spec))
     (stubs binary-search)
     (version . ,(lookup 'version spec))
     (skeleton . "binary-search.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism 'binary-search
                                   `((sentence
                                      "If the element is not present in the array, return the symbol "
                                      (inline-code "'not-found")
                                      ".")
                                     (sentence
                                      "The array will be passed as a vector.")))))))

