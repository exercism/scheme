(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
                   equal?
                   rotate
                   '(,(lookup-spine '(input text) test)
                     ,(lookup-spine '(input shiftKey) test))
                   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test
                    (lookup 'cases (car (lookup 'cases spec)))))
       args))))

(let ((spec (get-test-specification 'rotational-cipher)))
  (put-problem!
   'rotational-cipher
   `((test
      .
      ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . ,"rotational-cipher.scm")
     (solution . ,"example.scm"))))

