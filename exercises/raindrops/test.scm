#!r6rs

(import (rnrs))

(define test-fields '(input output who))

(define (test-run-solution solution input)
  (if (procedure? solution) (apply solution input) solution))

(define (test-success description success-predicate
         procedure input output)
  (call/cc
    (lambda (k)
      (with-exception-handler
        (lambda (e)
          (k `(fail
                (description . ,description)
                (input . ,input)
                (output . ,output)
                (who . ,procedure))))
        (lambda ()
          (let ([result (test-run-solution procedure input)])
            (unless (success-predicate result output)
              (error 'exercism-test
                "test fails"
                description
                input
                result
                output)))
          `(pass . ,description))))))

(define (test-error description procedure input)
  (call/cc
    (lambda (k)
      (with-exception-handler
        (lambda (e) (k `(pass . ,description)))
        (lambda ()
          (test-run-solution procedure input)
          `(fail
             (description . ,description)
             (input . ,input)
             (output . error)
             (who . ,procedure)))))))

(define (run-test-suite tests . query)
  (for-each
    (lambda (field)
      (unless (and (symbol? field) (memq field test-fields))
        (error 'run-test-suite
          (format "~a not in ~a" field test-fields))))
    query)
  (let-values ([(passes failures)
                (partition
                  (lambda (result) (eq? 'pass (car result)))
                  (map (lambda (test) (test)) tests))])
    (cond
      [(null? failures) (format #t "~%Well done!~%~%") 'success]
      [else
       (format
         #t
         "~%Passed ~a/~a tests.~%~%The following test cases failed:~%~%"
         (length passes)
         (length tests))
       (for-each
         (lambda (failure)
           (format
             #t
             "* ~a~%"
             (cond
               [(assoc 'description (cdr failure)) => cdr]
               [else (cdr failure)]))
           (for-each
             (lambda (field)
               (let ([info (assoc field (cdr failure))])
                 (format #t "  - ~a: ~a~%" (car info) (cdr info))))
             query))
         failures)
       (newline)
       'failure])))

(define (test . args)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "the sound for 1 is 1" equal? convert '(1)
          "1"))
      (lambda ()
        (test-success "the sound for 3 is Pling" equal? convert '(3)
          "Pling"))
      (lambda ()
        (test-success "the sound for 5 is Plang" equal? convert '(5)
          "Plang"))
      (lambda ()
        (test-success "the sound for 7 is Plong" equal? convert '(7)
          "Plong"))
      (lambda ()
        (test-success
          "the sound for 6 is Pling as it has a factor 3" equal?
          convert '(6) "Pling"))
      (lambda ()
        (test-success
          "2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base"
          equal? convert '(8) "8"))
      (lambda ()
        (test-success
          "the sound for 9 is Pling as it has a factor 3" equal?
          convert '(9) "Pling"))
      (lambda ()
        (test-success
          "the sound for 10 is Plang as it has a factor 5" equal?
          convert '(10) "Plang"))
      (lambda ()
        (test-success
          "the sound for 14 is Plong as it has a factor of 7" equal?
          convert '(14) "Plong"))
      (lambda ()
        (test-success
          "the sound for 15 is PlingPlang as it has factors 3 and 5"
          equal? convert '(15) "PlingPlang"))
      (lambda ()
        (test-success
          "the sound for 21 is PlingPlong as it has factors 3 and 7"
          equal? convert '(21) "PlingPlong"))
      (lambda ()
        (test-success
          "the sound for 25 is Plang as it has a factor 5" equal?
          convert '(25) "Plang"))
      (lambda ()
        (test-success
          "the sound for 27 is Pling as it has a factor 3" equal?
          convert '(27) "Pling"))
      (lambda ()
        (test-success
          "the sound for 35 is PlangPlong as it has factors 5 and 7"
          equal? convert '(35) "PlangPlong"))
      (lambda ()
        (test-success
          "the sound for 49 is Plong as it has a factor 7" equal?
          convert '(49) "Plong"))
      (lambda ()
        (test-success "the sound for 52 is 52" equal? convert '(52)
          "52"))
      (lambda ()
        (test-success
          "the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7"
          equal? convert '(105) "PlingPlangPlong"))
      (lambda ()
        (test-success
          "the sound for 3125 is Plang as it has a factor 5" equal?
          convert '(3125) "Plang")))
    args))

