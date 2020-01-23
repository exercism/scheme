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

(define nucleotide-count)

(define test-cases
  (list
    (lambda ()
      (test-success "empty strand"
        (lambda (xs ys)
          (letrec ([make-list (lambda (x n)
                                (if (zero? n)
                                    '()
                                    (cons x (make-list x (- n 1)))))]
                   [count->list (lambda (z)
                                  (list-sort
                                    char<?
                                    (apply
                                      append
                                      (map (lambda (x)
                                             (make-list (car x) (cdr x)))
                                           z))))])
            (equal? (count->list xs) (count->list ys))))
        nucleotide-count '("")
        '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0))))
    (lambda ()
      (test-success "can count one nucleotide in single-character input"
        (lambda (xs ys)
          (letrec ([make-list (lambda (x n)
                                (if (zero? n)
                                    '()
                                    (cons x (make-list x (- n 1)))))]
                   [count->list (lambda (z)
                                  (list-sort
                                    char<?
                                    (apply
                                      append
                                      (map (lambda (x)
                                             (make-list (car x) (cdr x)))
                                           z))))])
            (equal? (count->list xs) (count->list ys))))
        nucleotide-count '("G")
        '((#\A . 0) (#\C . 0) (#\G . 1) (#\T . 0))))
    (lambda ()
      (test-success "strand with repeated nucleotide"
        (lambda (xs ys)
          (letrec ([make-list (lambda (x n)
                                (if (zero? n)
                                    '()
                                    (cons x (make-list x (- n 1)))))]
                   [count->list (lambda (z)
                                  (list-sort
                                    char<?
                                    (apply
                                      append
                                      (map (lambda (x)
                                             (make-list (car x) (cdr x)))
                                           z))))])
            (equal? (count->list xs) (count->list ys))))
        nucleotide-count '("GGGGGGG")
        '((#\A . 0) (#\C . 0) (#\G . 7) (#\T . 0))))
    (lambda ()
      (test-success "strand with multiple nucleotides"
        (lambda (xs ys)
          (letrec ([make-list (lambda (x n)
                                (if (zero? n)
                                    '()
                                    (cons x (make-list x (- n 1)))))]
                   [count->list (lambda (z)
                                  (list-sort
                                    char<?
                                    (apply
                                      append
                                      (map (lambda (x)
                                             (make-list (car x) (cdr x)))
                                           z))))])
            (equal? (count->list xs) (count->list ys))))
        nucleotide-count
        '("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
        '((#\A . 20) (#\C . 12) (#\G . 17) (#\T . 21))))
    (lambda ()
      (test-error
        "strand with invalid nucleotides"
        nucleotide-count
        '("AGXXACT")))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "nucleotide-count.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load "nucleotide-count.scm")
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

