
(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
                   equal?
                   pascals-triangle
                   '(,(cdar (lookup 'input test)))
                   ',(lookup 'expected test))))

(define (test-2^n n)
  `(lambda ()
     (test-success "all rows sum to power of 2"
                   (lambda (n ignore)
                     (null?
                       (filter not
                               (map (lambda (row)
                                      (= 1 (bitwise-bit-count (apply + row))))
                                    (pascals-triangle n)))))
                   (lambda (x) x)
                   '(,n)
                   'ignore)))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test
                    (lookup 'cases
                            (car
                             (lookup 'cases spec))))
             ,(test-2^n 100))
       args))))

(let ((spec (get-test-specification 'pascals-triangle)))
  (put-problem!
   'pascals-triangle
   `((test
      .
      ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "pascals-triangle.scm")
     (solution . "example.scm"))))

