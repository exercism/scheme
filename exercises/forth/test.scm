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

(define (run-docker test-cases)
  (write (map (lambda (test) (test)) test-cases)))

(define forth)

(define test-cases
  (list
   (lambda ()
     (test-success "numbers just get pushed onto the stack"
       equal? forth '(("1 2 3 4 5")) '(5 4 3 2 1)))
   (lambda ()
     (test-success "can add two numbers" equal? forth
       '(("1 2 +")) '(3)))
   (lambda ()
     (test-error
       "errors if there is nothing on the stack"
       forth
       '(("+"))))
   (lambda ()
     (test-error
       "errors if there is only one value on the stack"
       forth
       '(("1 +"))))
   (lambda ()
     (test-success "can subtract two numbers" equal? forth
       '(("3 4 -")) '(-1)))
   (lambda ()
     (test-error
       "errors if there is nothing on the stack"
       forth
       '(("-"))))
   (lambda ()
     (test-error
       "errors if there is only one value on the stack"
       forth
       '(("1 -"))))
   (lambda ()
     (test-success "can multiply two numbers" equal? forth
       '(("2 4 *")) '(8)))
   (lambda ()
     (test-error
       "errors if there is nothing on the stack"
       forth
       '(("*"))))
   (lambda ()
     (test-error
       "errors if there is only one value on the stack"
       forth
       '(("1 *"))))
   (lambda ()
     (test-success "can divide two numbers" equal? forth
       '(("12 3 /")) '(4)))
   (lambda ()
     (test-success "performs integer division" equal? forth
       '(("8 3 /")) '(2)))
   (lambda ()
     (test-error
       "errors if dividing by zero"
       forth
       '(("4 0 /"))))
   (lambda ()
     (test-error
       "errors if there is nothing on the stack"
       forth
       '(("/"))))
   (lambda ()
     (test-error
       "errors if there is only one value on the stack"
       forth
       '(("1 /"))))
   (lambda ()
     (test-success "addition and subtraction" equal? forth
       '(("1 2 + 4 -")) '(-1)))
   (lambda ()
     (test-success "multiplication and division" equal? forth
       '(("2 4 * 3 /")) '(2)))
   (lambda ()
     (test-success "copies a value on the stack" equal? forth
       '(("1 dup")) '(1 1)))
   (lambda ()
     (test-success "copies the top value on the stack" equal?
       forth '(("1 2 dup")) '(2 2 1)))
   (lambda ()
     (test-error
       "errors if there is nothing on the stack"
       forth
       '(("dup"))))
   (lambda ()
     (test-success
       "removes the top value on the stack if it is the only one"
       equal? forth '(("1 drop")) '()))
   (lambda ()
     (test-success
       "removes the top value on the stack if it is not the only one"
       equal? forth '(("1 2 drop")) '(1)))
   (lambda ()
     (test-error
       "errors if there is nothing on the stack"
       forth
       '(("drop"))))
   (lambda ()
     (test-success
       "swaps the top two values on the stack if they are the only ones"
       equal? forth '(("1 2 swap")) '(1 2)))
   (lambda ()
     (test-success
       "swaps the top two values on the stack if they are not the only ones"
       equal? forth '(("1 2 3 swap")) '(2 3 1)))
   (lambda ()
     (test-error
       "errors if there is nothing on the stack"
       forth
       '(("swap"))))
   (lambda ()
     (test-error
       "errors if there is only one value on the stack"
       forth
       '(("1 swap"))))
   (lambda ()
     (test-success
       "copies the second element if there are only two" equal?
       forth '(("1 2 over")) '(1 2 1)))
   (lambda ()
     (test-success
       "copies the second element if there are more than two"
       equal? forth '(("1 2 3 over")) '(2 3 2 1)))
   (lambda ()
     (test-error
       "errors if there is nothing on the stack"
       forth
       '(("over"))))
   (lambda ()
     (test-error
       "errors if there is only one value on the stack"
       forth
       '(("1 over"))))
   (lambda ()
     (test-success "can consist of built-in words" equal? forth
       '((": dup-twice dup dup ;" "1 dup-twice")) '(1 1 1)))
   (lambda ()
     (test-success "execute in the right order" equal? forth
       '((": countup 1 2 3 ;" "countup")) '(3 2 1)))
   (lambda ()
     (test-success "can override other user-defined words" equal? forth
       '((": foo dup ;" ": foo dup dup ;" "1 foo")) '(1 1 1)))
   (lambda ()
     (test-success "can override built-in words" equal? forth
       '((": swap dup ;" "1 swap")) '(1 1)))
   (lambda ()
     (test-success "can override built-in operators" equal? forth
       '((": + * ;" "3 4 +")) '(12)))
   (lambda ()
     (test-success "can use different words with the same name" equal? forth
       '((": foo 5 ;" ": bar foo ;" ": foo 6 ;" "bar foo"))
       '(6 5)))
   (lambda ()
     (test-success "can define word that uses word with the same name" equal?
       forth '((": foo 10 ;" ": foo foo 1 + ;" "foo")) '(11)))
   (lambda ()
     (test-error "cannot redefine numbers" forth '((": 1 2 ;"))))
   (lambda ()
     (test-error
       "errors if executing a non-existent word"
       forth
       '(("foo"))))
   (lambda ()
     (test-success "DUP is case-insensitive" equal? forth
       '(("1 DUP Dup dup")) '(1 1 1 1)))
   (lambda ()
     (test-success "DROP is case-insensitive" equal? forth
       '(("1 2 3 4 DROP Drop drop")) '(1)))
   (lambda ()
     (test-success "SWAP is case-insensitive" equal? forth
       '(("1 2 SWAP 3 Swap 4 swap")) '(1 4 3 2)))
   (lambda ()
     (test-success "OVER is case-insensitive" equal? forth
       '(("1 2 OVER Over over")) '(1 2 1 2 1)))
   (lambda ()
     (test-success "user-defined words are case-insensitive" equal? forth
       '((": foo dup ;" "1 FOO Foo foo")) '(1 1 1 1)))
   (lambda ()
     (test-success "definitions are case-insensitive" equal?
       forth '((": SWAP DUP Dup dup ;" "1 swap")) '(1 1 1 1)))))

(define (test . query)
  (apply run-test-suite test-cases query))

(let ([args (command-line)])
  (cond
    [(null? (cdr args))
     (load "forth.scm")
     (test 'input 'output)]
    [(string=? (cadr args) "--docker")
     (load (caddr args))
     (run-docker test-cases)]
    [else (load (cadr args)) (test 'input 'output)]))

