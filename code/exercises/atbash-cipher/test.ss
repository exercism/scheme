
(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 equal?
                 ,(string->symbol
                   (lookup 'property test))
                 '(,(cdar (lookup 'input test)))
                 ;; note it's just input that needs to be list
                 ,(lookup 'expected test)))

(define (spec->tests spec)
  (map parse-test (apply append
                         (map (lookup 'cases)
                              (lookup 'cases spec)))))

(let ((spec (get-test-specification 'atbash-cipher)))
  (put-problem!
   'atbash-cipher
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "atbash-cipher.scm")
     (solution . "example.scm")
     (stubs encode decode)
     (markdown . ,(splice-exercism 'atbash-cipher)))))
