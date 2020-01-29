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

(define hamming-distance)

(define test-cases
  (list
    (lambda ()
      (test-success "empty strands" = hamming-distance '("" "")
        0))
    (lambda ()
      (test-success "single letter identical strands" =
        hamming-distance '("A" "A") 0))
    (lambda ()
      (test-success "single letter different strands" =
        hamming-distance '("G" "T") 1))
    (lambda ()
      (test-success "long identical strands" = hamming-distance
        '("GGACTGAAATCTG" "GGACTGAAATCTG") 0))
    (lambda ()
      (test-success "long different strands" = hamming-distance
        '("GGACGGATTCTG" "AGGACGGATTCT") 9))
    (lambda ()
      (test-error
        "disallow first strand longer"
        hamming-distance
        '("AATG" "AAA")))
    (lambda ()
      (test-error
        "disallow second strand longer"
        hamming-distance
        '("ATA" "AGTG")))
    (lambda ()
      (test-error
        "disallow left empty strand"
        hamming-distance
        '("" "G")))
    (lambda ()
      (test-error
        "disallow right empty strand"
        hamming-distance
        '("G" "")))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "hamming.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "hamming.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

