
(define (parse-test test)
  ;;  (let ((expected (lookup 'expected test))))
  (let ((expected (lookup 'expected test)))
    (if (string? expected)
        `(test-success ,(lookup 'description test)
                       equal?
                       clean
                       '(,(cdar (lookup 'input test)))
                       ,expected)
        `(test-error ,(lookup 'description test)
                     clean
                     '(,(cdar (lookup 'input test)))))))

(define (spec->tests spec)
  (map parse-test (lookup 'cases
                          (car (lookup 'cases spec)))))

(let ((spec (get-test-specification 'phone-number)))
  (put-problem!
   'phone-number
   `((test . ,(spec->tests spec))
     (stubs clean)
     (version . ,(lookup 'version spec))
     (skeleton . "phone-number.scm")
     (solution . "example.scm")
     (hints.md . ,(splice-exercism 'phone-number)))))

