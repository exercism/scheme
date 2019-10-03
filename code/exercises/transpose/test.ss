(define (parse-test test)
  (let* ((lines (cdar (lookup 'input test)))
         (n (length lines))
         (m (if (zero? n) 0
                (apply max (map string-length lines))))
         (fill-string (lambda (s k)
                        (string-append s
                                       (make-string (- k (string-length s))
                                                    #\space)))))
    `(lambda ()
       (test-success ,(lookup 'description test)
                     equal?
                     transpose
                     '(,(map (lambda (s)
                               (map char->integer
                                    (string->list
                                     (fill-string s m))))
                             lines))
                     '(,@(map (lambda (s)
                                (map char->integer
                                     (string->list
                                      (fill-string s n))))
                              (lookup 'expected test)))))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec)))
       args))))

(put-problem!
 'transpose
 `((test
    .
    ,(spec->tests (get-test-specification 'transpose)))
   (skeleton . ,"transpose.scm")
   (solution . ,"example.scm")))

