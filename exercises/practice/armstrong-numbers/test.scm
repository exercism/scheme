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

(define armstrong-number?)

(define test-cases
  (list
    (lambda ()
      (test-success
        "Zero is an Armstrong number" equal?
        armstrong-number? '(0) #t))
    (lambda ()
      (test-success
        "Single digit numbers are Armstrong numbers" equal?
        armstrong-number? '(5) #t))
    (lambda ()
      (test-success
        "There are no 2 digit Armstrong numbers" equal?
        armstrong-number? '(10) #f))
    (lambda ()
      (test-success
        "Three digit number that is an Armstrong number" equal?
        armstrong-number? '(153) #t))
    (lambda ()
      (test-success
        "Three digit number that is not an Armstrong number" equal?
        armstrong-number? '(100) #f))
    (lambda ()
      (test-success
        "Four digit number that is an Armstrong number" equal?
        armstrong-number? '(9474) #t))
    (lambda ()
      (test-success
        "Four digit number that is not an Armstrong number" equal?
        armstrong-number? '(9475) #f))
    (lambda ()
      (test-success
        "Seven digit number that is an Armstrong number" equal?
        armstrong-number? '(9926315) #t))
    (lambda ()
      (test-success
        "Seven digit number that is not an Armstrong number" equal?
        armstrong-number? '(9926314) #f))
    (lambda ()
      (test-success
        "The 25th Armstrong number" equal?
        armstrong-number? '(24678050) #t))
    (lambda ()
      (test-success
        "Eight digit number that is not an Armstrong number" equal?
        armstrong-number? '(30852815) #f))
    (lambda ()
      (test-success
        "The 28th Armstrong number" equal?
        armstrong-number? '(146511208) #t))
    (lambda ()
      (test-success
        "Nine digit number that is not an Armstrong number" equal?
        armstrong-number? '(927427554) #f))
    (lambda ()
      (test-success
        "The 32nd Armstrong number" equal?
        armstrong-number? '(4679307774) #t))
    (lambda ()
      (test-success
        "Ten digit number that is not an Armstrong number" equal?
        armstrong-number? '(8320172640) #f))
    (lambda ()
      (test-success
        "The 34th Armstrong number" equal?
        armstrong-number? '(32164049651) #t))
    (lambda ()
      (test-success
        "Eleven digit number that is not an Armstrong number" equal?
        armstrong-number? '(13930642218) #f))
    (lambda ()
      (test-success
        "The 66th Armstrong number" equal?
        armstrong-number? '(4422095118095899619457938) #t))
    (lambda ()
      (test-success
        "The 77th Armstrong number" equal?
        armstrong-number? '(1927890457142960697580636236639) #t))
    (lambda ()
      (test-success
        "The 88th Armstrong number" equal?
        armstrong-number? '(115132219018763992565095597973971522401) #t))
    (lambda ()
      (test-success
        "Thirty-nine digit number that is not an Armstrong number" equal?
        armstrong-number? '(7744959048678381442547644364350528967165) #f))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "armstrong-numbers.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "armstrong-numbers.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

