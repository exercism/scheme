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
                 (display "  - ")
                 (write (car info))
                 (display ": ")
                 (write (cdr info))
                 (newline)))
             query))
         failures)
       (error 'test "incorrect solution")])))

(define balanced?)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "paired square brackets" eq? balanced? '("[]")
          #t))
      (lambda ()
        (test-success "empty string" eq? balanced? '("") #t))
      (lambda ()
        (test-success "unpaired brackets" eq? balanced? '("[[") #f))
      (lambda ()
        (test-success "wrong ordered brackets" eq? balanced? '("}{")
          #f))
      (lambda ()
        (test-success "wrong closing bracket" eq? balanced? '("{]")
          #f))
      (lambda ()
        (test-success "paired with whitespace" eq? balanced?
          '("{ }") #t))
      (lambda ()
        (test-success "partially paired brackets" eq? balanced?
          '("{[])") #f))
      (lambda ()
        (test-success "simple nested brackets" eq? balanced?
          '("{[]}") #t))
      (lambda ()
        (test-success "several paired brackets" eq? balanced?
          '("{}[]") #t))
      (lambda ()
        (test-success "paired and nested brackets" eq? balanced?
          '("([{}({}[])])") #t))
      (lambda ()
        (test-success "unopened closing brackets" eq? balanced?
          '("{[)][]}") #f))
      (lambda ()
        (test-success "unpaired and nested brackets" eq? balanced?
          '("([{])") #f))
      (lambda ()
        (test-success "paired and wrong nested brackets" eq?
          balanced? '("[({]})") #f))
      (lambda ()
        (test-success "paired and incomplete brackets" eq? balanced?
          '("{}[") #f))
      (lambda ()
        (test-success "too many closing brackets" eq? balanced?
          '("[]]") #f))
      (lambda ()
        (test-success "math expression" eq? balanced?
          '("(((185 + 223.85) * 15) - 543)/2") #t))
      (lambda ()
        (test-success "complex latex expression" eq? balanced?
          '("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")
          #t)))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "matching-brackets.scm")
      (load (cadr args)))
  (test 'input 'output))

