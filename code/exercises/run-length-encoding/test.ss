(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
                   string=?
                   ,(string->symbol (lookup 'property test))
                   '(,(cdar (lookup 'input test)))
                   ,(lookup 'expected test))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (consistency s)
      (decode (encode s)))
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test
                    (apply append
                           (map (lookup-partial 'cases)
                                (lookup 'cases spec)))))
       args))))

(let ((spec (get-test-specification 'run-length-encoding)))
  (put-problem!
   'run-length-encoding
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "run-length-encoding.scm")
     (solution . "example.scm")
     (hints.md . ,(splice-exercism 'run-length-encoding)))))

