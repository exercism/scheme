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

(define transpose)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "empty string" equal? transpose '(()) '()))
      (lambda ()
        (test-success "two characters in a row" equal? transpose
          '(((65 49))) '((65) (49))))
      (lambda ()
        (test-success "two characters in a column" equal? transpose
          '(((65) (49))) '((65 49))))
      (lambda ()
        (test-success "simple" equal? transpose
          '(((65 66 67) (49 50 51))) '((65 49) (66 50) (67 51))))
      (lambda ()
        (test-success "single line" equal? transpose
          '(((83 105 110 103 108 101 32 108 105 110 101 46)))
          '((83) (105) (110) (103) (108) (101) (32) (108) (105) (110)
             (101) (46))))
      (lambda ()
        (test-success "first line longer than second line" equal? transpose
          '(((84 104 101 32 102 111 117 114 116 104 32 108 105 110 101
                 46)
              (84 104 101 32 102 105 102 116 104 32 108 105 110 101 46
                  32)))
          '((84 84) (104 104) (101 101) (32 32) (102 102) (111 105) (117 102)
             (114 116) (116 104) (104 32) (32 108) (108 105) (105 110)
             (110 101) (101 46) (46 32))))
      (lambda ()
        (test-success "second line longer than first line" equal? transpose
          '(((84 104 101 32 102 105 114 115 116 32 108 105 110 101 46
                 32)
              (84 104 101 32 115 101 99 111 110 100 32 108 105 110 101
                  46)))
          '((84 84) (104 104) (101 101) (32 32) (102 115) (105 101) (114 99)
             (115 111) (116 110) (32 100) (108 32) (105 108) (110 105)
             (101 110) (46 101) (32 46))))
      (lambda ()
        (test-success "mixed line length" equal? transpose
          '(((84 104 101 32 108 111 110 103 101 115 116 32 108 105 110
                 101 46)
              (65 32 108 111 110 103 32 108 105 110 101 46 32 32 32 32 32)
              (65 32 108 111 110 103 101 114 32 108 105 110 101 46 32 32
                  32)
              (65 32 108 105 110 101 46 32 32 32 32 32 32 32 32 32 32)))
          '((84 65 65 65) (104 32 32 32) (101 108 108 108) (32 111 111 105)
             (108 110 110 110) (111 103 103 101) (110 32 101 46)
             (103 108 114 32) (101 105 32 32) (115 110 108 32)
             (116 101 105 32) (32 46 110 32) (108 32 101 32)
             (105 32 46 32) (110 32 32 32) (101 32 32 32)
             (46 32 32 32))))
      (lambda ()
        (test-success "square" equal? transpose
          '(((72 69 65 82 84)
              (69 77 66 69 82)
              (65 66 85 83 69)
              (82 69 83 73 78)
              (84 82 69 78 68)))
          '((72 69 65 82 84)
             (69 77 66 69 82)
             (65 66 85 83 69)
             (82 69 83 73 78)
             (84 82 69 78 68))))
      (lambda ()
        (test-success "rectangle" equal? transpose
          '(((70 82 65 67 84 85 82 69)
              (79 85 84 76 73 78 69 68)
              (66 76 79 79 77 73 78 71)
              (83 69 80 84 69 84 84 69)))
          '((70 79 66 83) (82 85 76 69) (65 84 79 80) (67 76 79 84) (84 73 77 69)
             (85 78 73 84) (82 69 78 84) (69 68 71 69))))
      (lambda ()
        (test-success "triangle" equal? transpose
          '(((84 32 32 32 32 32) (69 69 32 32 32 32) (65 65 65 32 32 32) (83 83 83 83 32 32)
              (69 69 69 69 69 32) (82 82 82 82 82 82)))
          '((84 69 65 83 69 82) (32 69 65 83 69 82) (32 32 65 83 69 82) (32 32 32 83 69 82)
             (32 32 32 32 69 82) (32 32 32 32 32 82)))))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "transpose.scm")
      (load (cadr args)))
  (test 'input 'output))

