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

(define encode)

(define decode)

(define test-cases
  (list
    (lambda ()
      (test-success "encode yes" equal? encode '("yes") "bvh"))
    (lambda ()
      (test-success "encode no" equal? encode '("no") "ml"))
    (lambda ()
      (test-success "encode OMG" equal? encode '("OMG") "lnt"))
    (lambda ()
      (test-success "encode spaces" equal? encode '("O M G")
        "lnt"))
    (lambda ()
      (test-success "encode mindblowingly" equal? encode
        '("mindblowingly") "nrmwy oldrm tob"))
    (lambda ()
      (test-success "encode numbers" equal? encode
        '("Testing,1 2 3, testing.") "gvhgr mt123 gvhgr mt"))
    (lambda ()
      (test-success "encode deep thought" equal? encode
        '("Truth is fiction.") "gifgs rhurx grlm"))
    (lambda ()
      (test-success "encode all the letters" equal? encode
        '("The quick brown fox jumps over the lazy dog.")
        "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"))
    (lambda ()
      (test-success "decode exercism" equal? decode '("vcvix rhn")
        "exercism"))
    (lambda ()
      (test-success "decode a sentence" equal? decode
        '("zmlyh gzxov rhlug vmzhg vkkrm thglm v")
        "anobstacleisoftenasteppingstone"))
    (lambda ()
      (test-success "decode numbers" equal? decode
        '("gvhgr mt123 gvhgr mt") "testing123testing"))
    (lambda ()
      (test-success "decode all the letters" equal? decode
        '("gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt")
        "thequickbrownfoxjumpsoverthelazydog"))
    (lambda ()
      (test-success "decode with too many spaces" equal? decode
        '("vc vix    r hn") "exercism"))
    (lambda ()
      (test-success "decode with no spaces" equal? decode
        '("zmlyhgzxovrhlugvmzhgvkkrmthglmv")
        "anobstacleisoftenasteppingstone"))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "atbash-cipher.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "atbash-cipher.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

