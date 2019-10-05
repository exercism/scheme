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
          (format #t "~a not in ~a" field test-fields))))
    query)
  (let-values ([(passes failures)
                (partition
                  (lambda (result) (eq? 'pass (car result)))
                  (map (lambda (test) (test)) tests))])
    (cond
      [(null? failures) (format #t "~%Well done!~%~%")]
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
       (error 'test "incorrect solution")])))

(define knapsack)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "no items" = knapsack '(100 () ()) 0))
      (lambda ()
        (test-success "one item, too heavy" = knapsack
          '(10 (100) (1)) 0))
      (lambda ()
        (test-success "five items (cannot be greedy by weight)" =
          knapsack '(10 (2 2 2 2 10) (5 5 5 5 21)) 21))
      (lambda ()
        (test-success "five items (cannot be greedy by value)" =
          knapsack '(10 (2 2 2 2 10) (20 20 20 20 50)) 80))
      (lambda ()
        (test-success "example knapsack" = knapsack
          '(10 (5 4 6 4) (10 40 30 50)) 90))
      (lambda ()
        (test-success "8 items" = knapsack
          '(104 (25 35 45 5 25 3 2 2) (350 400 450 20 70 8 5 5)) 900))
      (lambda ()
        (test-success "15 items" = knapsack
          '(750 (70 73 77 80 82 87 90 94 98 106 110 113 115 118 120)
                (135 139 149 150 156 163 173 184 192 201 210 214 221 229
                     240))
          1458))
      (lambda ()
        (test-success "example with 30 items" = knapsack
          '(100000
             (90001 89751 10002 89501 10254 89251 10506 89001 10758 88751
              11010 88501 11262 88251 11514 88001 11766 87751 12018 87501
              12270 87251 12522 87001 12774 86751 13026 86501 13278 86251)
             (90000 89750 10001 89500 10252 89250 10503 89000 10754 88750
              11005 88500 11256 88250 11507 88000 11758 87750 12009 87500
              12260 87250 12511 87000 12762 86750 13013 86500 13264
              86250))
          99798))
      (lambda ()
        (test-success "example with 50 items" = knapsack
          '(341045
             (4912 99732 56554 1818 108372 6750 1484 3072 13532 12050
              18440 10972 1940 122094 5558 10630 2112 6942 39888 71276
              8466 5662 231302 4690 18324 3384 7278 5566 706 10992 27552
              7548 934 32038 1062 184848 2604 37644 1832 10306 1126 34886
              3526 1196 1338 992 1390 56804 56804 634)
             (1906 41516 23527 559 45136 2625 492 1086 5516 4875 7570 4436
              620 50897 2129 4265 706 2721 16494 29688 3383 2181 96601
              1795 7512 1242 2889 2133 103 4446 11326 3024 217 13269 281
              77174 952 15572 566 4103 313 14393 1313 348 419 246 445
              23552 23552 67))
          142156)))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "knapsack.scm")
      (load (cadr args)))
  (test 'input 'output))

