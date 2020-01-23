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
      (test-success "encode yes" equal? encode '((5 . 7) "yes")
        "xbt"))
    (lambda ()
      (test-success "encode no" equal? encode '((15 . 18) "no")
        "fu"))
    (lambda ()
      (test-success "encode OMG" equal? encode '((21 . 3) "OMG")
        "lvz"))
    (lambda ()
      (test-success "encode O M G" equal? encode
        '((25 . 47) "O M G") "hjp"))
    (lambda ()
      (test-success "encode mindblowingly" equal? encode
        '((11 . 15) "mindblowingly") "rzcwa gnxzc dgt"))
    (lambda ()
      (test-success "encode numbers" equal? encode
        '((3 . 4) "Testing,1 2 3, testing.")
        "jqgjc rw123 jqgjc rw"))
    (lambda ()
      (test-success "encode deep thought" equal? encode
        '((5 . 17) "Truth is fiction.") "iynia fdqfb ifje"))
    (lambda ()
      (test-success "encode all the letters" equal? encode
        '((17 . 33) "The quick brown fox jumps over the lazy dog.")
        "swxtj npvyk lruol iejdc blaxk swxmh qzglf"))
    (lambda ()
      (test-error
        "encode with a not coprime to m"
        encode
        '(((a . 6) (b . 17)) "This is a test.")))
    (lambda ()
      (test-success "decode exercism" equal? decode
        '((3 . 7) "tytgn fjr") "exercism"))
    (lambda ()
      (test-success "decode a sentence" equal? decode
        '((19 . 16) "qdwju nqcro muwhn odqun oppmd aunwd o")
        "anobstacleisoftenasteppingstone"))
    (lambda ()
      (test-success "decode numbers" equal? decode
        '((25 . 7) "odpoz ub123 odpoz ub") "testing123testing"))
    (lambda ()
      (test-success "decode all the letters" equal? decode
        '((17 . 33) "swxtj npvyk lruol iejdc blaxk swxmh qzglf")
        "thequickbrownfoxjumpsoverthelazydog"))
    (lambda ()
      (test-success "decode with no spaces in input" equal? decode
        '((17 . 33) "swxtjnpvyklruoliejdcblaxkswxmhqzglf")
        "thequickbrownfoxjumpsoverthelazydog"))
    (lambda ()
      (test-success "decode with too many spaces" equal? decode
        '((15 . 16) "vszzm    cly   yd cg    qdp")
        "jollygreengiant"))
    (lambda ()
      (test-error
        "decode with a not coprime to m"
        decode
        '(((a . 13) (b . 5)) "Test")))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "affine-cipher.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "affine-cipher.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

