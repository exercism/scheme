(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 equal?
                 rotate
                 '(,(lookup-spine '(input text) test)
                   ,(lookup-spine '(input shiftKey) test))
                 ,(lookup 'expected test)))

(define (spec->tests spec)
  (map parse-test
       (lookup 'cases (car (lookup 'cases spec)))))

(let ((spec (get-test-specification 'rotational-cipher)))
  (put-problem!
   'rotational-cipher
   `((test . ,(spec->tests spec))
     (stubs rotate)
     (version . ,(lookup 'version spec))
     (skeleton . "rotational-cipher.scm")
     (solution . "example.scm")
     (markdown . ,(splice-exercism 'rotational-cipher)))))

