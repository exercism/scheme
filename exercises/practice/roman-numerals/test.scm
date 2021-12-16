(import (except (rnrs) current-output-port))

(define test-fields '(input output))

(define (test-run-solution solution input)
  (if (procedure? solution) (apply solution input) solution))

(define (test-success description success-predicate
         procedure input output)
  (call/cc
    (lambda (k)
      (let ([out (open-output-string)])
        (with-exception-handler
          (lambda (e)
            (let ([result `(fail
                             (description . ,description)
                             (input . ,input)
                             (output . ,output)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              (k result)))
          (lambda ()
            (let ([result (parameterize ([current-output-port out])
                            (test-run-solution procedure input))])
              (unless (success-predicate result output)
                (error 'exercism-test
                  "test fails"
                  description
                  input
                  result
                  output)))
            (let ([result `(pass
                             (description . ,description)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              result)))))))

(define (test-error description procedure input)
  (call/cc
    (lambda (k)
      (let ([out (open-output-string)])
        (with-exception-handler
          (lambda (e)
            (let ([result `(pass
                             (description . ,description)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              (k result)))
          (lambda ()
            (parameterize ([current-output-port out])
              (test-run-solution procedure input))
            (let ([result `(fail
                             (description . ,description)
                             (input . ,input)
                             (output . error)
                             (stdout . ,(get-output-string out)))])
              (close-output-port out)
              result)))))))

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
                 (display "  - ")
                 (write (car info))
                 (display ": ")
                 (write (cdr info))
                 (newline)))
             query))
         failures)
       (error 'test "incorrect solution")])))

(define (run-docker test-cases)
  (write (map (lambda (test) (test)) test-cases)))

(define roman)

(define test-cases
  (list
    (lambda ()
      (test-success "1 is a single I" equal? roman '(1) "I"))
    (lambda ()
      (test-success "2 is two I's" equal? roman '(2) "II"))
    (lambda ()
      (test-success "3 is three I's" equal? roman '(3) "III"))
    (lambda ()
      (test-success "4, being 5 - 1, is IV" equal? roman '(4) "IV"))
    (lambda ()
      (test-success "5 is a single V" equal? roman '(5) "V"))
    (lambda ()
      (test-success "6, being 5 + 1, is VI" equal? roman '(6) "VI"))
    (lambda ()
      (test-success "9, being 10 - 1, is IX" equal? roman '(9) "IX"))
    (lambda ()
      (test-success "20 is two X's" equal? roman '(20) "XX"))
    (lambda ()
      (test-success "27 is 10 + 10 + 5 + 1 + 1" equal? roman '(27) "XXVII"))
    (lambda ()
      (test-success "48 is not 50 - 2 but rather 40 + 8" equal? roman
                    '(48) "XLVIII"))
    (lambda ()
      (test-success "49 is not 40 + 5 + 4 but rather 50 - 10 + 10 - 1" equal?
                    roman '(49) "XLIX"))
    (lambda ()
      (test-success "50 is a single L" equal? roman '(50) "L"))
    (lambda ()
      (test-success "59 is 50 + 10 - 1" equal? roman '(59) "LIX"))
    (lambda ()
      (test-success "60, being 50 + 10, is LX" equal? roman '(60) "LX"))
    (lambda ()
      (test-success "90, being 100 - 10, is XC" equal? roman '(90) "XC"))
    (lambda ()
      (test-success "93 is 100 - 10 + 1 + 1 + 1" equal? roman '(93) "XCIII"))
    (lambda ()
      (test-success "100 is a single C" equal? roman '(100) "C"))
    (lambda ()
      (test-success "141 is 100 + 50 - 10 + 1" equal? roman '(141) "CXLI"))
    (lambda ()
      (test-success "163 is 100 + 50 + 10 + 1 + 1 + 1" equal? roman
                    '(163) "CLXIII"))
    (lambda ()
      (test-success "400, being 500 - 100, is CD" equal? roman '(400) "CD"))
    (lambda ()
      (test-success "402 is 500 - 100 + 2" equal? roman '(402) "CDII"))
    (lambda ()
      (test-success "500 is a single D" equal? roman '(500) "D"))
    (lambda ()
      (test-success "575 is 500 + 50 + 10 + 10 + 5" equal? roman
                    '(575) "DLXXV"))
    (lambda ()
      (test-success "900, being 1000 - 100, is CM" equal? roman '(900) "CM"))
    (lambda ()
      (test-success "911 is 1000 - 100 + 10 + 1" equal? roman '(911) "CMXI"))
    (lambda ()
      (test-success "1000 is a single M" equal? roman '(1000) "M"))
    (lambda ()
      (test-success "1024 is 1000 + 10 + 10 + 5 - 1" equal? roman
                    '(1024) "MXXIV"))
    (lambda ()
      (test-success "3000 is three M's" equal? roman '(3000) "MMM"))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "roman-numerals.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "roman-numerals.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

