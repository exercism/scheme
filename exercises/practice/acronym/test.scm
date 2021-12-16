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

(define acronym)

(define test-cases
  (list
    (lambda ()
      (test-success "basic" equal? acronym '("Portable Network Graphics") "PNG"))
    (lambda ()
      (test-success "lowercase words" equal? acronym '("Ruby on Rails") "ROR"))
    (lambda ()
      (test-success "punctuation" equal? acronym '("First In, First Out") "FIFO"))
    (lambda ()
      (test-success
        "all caps word" equal? acronym '("GNU Image Manipulation Program") "GIMP"))
    (lambda ()
      (test-success "colon" equal? acronym '("PHP: Hypertext Preprocessor") "PHP"))
    (lambda ()
      (test-success
        "punctuation without whitespace" equal? acronym
        '("Complementary metal-oxide semiconductor") "CMOS"))
    (lambda ()
      (test-success
        "very long abbreviation" equal? acronym
        '("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me")
        "ROTFLSHTMDCOALM"))
    (lambda ()
      (test-success
        "consecutive delimiters" equal? acronym
        '("Something - I made up from thin air") "SIMUFTA"))
    (lambda ()
      (test-success "apostrophes" equal? acronym '("Halley's Comet") "HC"))
    (lambda ()
      (test-success
        "underscore emphasis" equal? acronym '("The Road _Not_ Taken") "TRNT"))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "acronym.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "acronym.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

