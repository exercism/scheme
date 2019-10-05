(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 equal?
                 hello-world
                 '()
                 ,(lookup 'expected test)))

(let ((spec (get-test-specification 'hello-world)))
  (put-problem!
   'hello-world
   `((test
      .
      ,(map parse-test (lookup 'cases spec)))
     (version . ,(lookup 'version spec))
     (skeleton . "hello-world.scm")
     (solution . "example.scm")
     (stubs hello-world)
     (hints.md . ,(splice-exercism
                   'hello-world
                   '(sentence "Your solution may be a procedure that
returns the desired string or a variable whose value is that
string."))))))

