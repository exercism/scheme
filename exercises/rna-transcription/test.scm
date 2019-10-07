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

(define dna->rna)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "Empty RNA sequence" equal? dna->rna '("")
          ""))
      (lambda ()
        (test-success "RNA complement of cytosine is guanine" equal?
          dna->rna '("C") "G"))
      (lambda ()
        (test-success "RNA complement of guanine is cytosine" equal?
          dna->rna '("G") "C"))
      (lambda ()
        (test-success "RNA complement of thymine is adenine" equal?
          dna->rna '("T") "A"))
      (lambda ()
        (test-success "RNA complement of adenine is uracil" equal?
          dna->rna '("A") "U"))
      (lambda ()
        (test-success "RNA complement" equal? dna->rna
          '("ACGTGGTCTTAA") "UGCACCAGAAUU")))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "rna-transcription.scm")
      (load (cadr args)))
  (test 'input 'output))

