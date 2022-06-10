(load "test-util.ss")

(define test-cases
  `((test-success "numbers just get pushed onto the stack"
      equal? forth '(("1 2 3 4 5")) '(5 4 3 2 1))
    (test-success "can add two numbers" equal? forth
      '(("1 2 +")) '(3))
    (test-error
      "errors if there is nothing on the stack"
      forth
      '(("+")))
    (test-error
      "errors if there is only one value on the stack"
      forth
      '(("1 +")))
    (test-success "can subtract two numbers" equal? forth
      '(("3 4 -")) '(-1))
    (test-error
      "errors if there is nothing on the stack"
      forth
      '(("-")))
    (test-error
      "errors if there is only one value on the stack"
      forth
      '(("1 -")))
    (test-success "can multiply two numbers" equal? forth
      '(("2 4 *")) '(8))
    (test-error
      "errors if there is nothing on the stack"
      forth
      '(("*")))
    (test-error
      "errors if there is only one value on the stack"
      forth
      '(("1 *")))
    (test-success "can divide two numbers" equal? forth
      '(("12 3 /")) '(4))
    (test-success "performs integer division" equal? forth
      '(("8 3 /")) '(2))
    (test-error "errors if dividing by zero" forth '(("4 0 /")))
    (test-error
      "errors if there is nothing on the stack"
      forth
      '(("/")))
    (test-error
      "errors if there is only one value on the stack"
      forth
      '(("1 /")))
    (test-success "addition and subtraction" equal? forth
      '(("1 2 + 4 -")) '(-1))
    (test-success "multiplication and division" equal? forth
      '(("2 4 * 3 /")) '(2))
    (test-success "copies a value on the stack" equal? forth
      '(("1 dup")) '(1 1))
    (test-success "copies the top value on the stack" equal?
      forth '(("1 2 dup")) '(2 2 1))
    (test-error
      "errors if there is nothing on the stack"
      forth
      '(("dup")))
    (test-success
      "removes the top value on the stack if it is the only one"
      equal? forth '(("1 drop")) '())
    (test-success
      "removes the top value on the stack if it is not the only one"
      equal? forth '(("1 2 drop")) '(1))
    (test-error
      "errors if there is nothing on the stack"
      forth
      '(("drop")))
    (test-success
      "swaps the top two values on the stack if they are the only ones"
      equal? forth '(("1 2 swap")) '(1 2))
    (test-success
      "swaps the top two values on the stack if they are not the only ones"
      equal? forth '(("1 2 3 swap")) '(2 3 1))
    (test-error
      "errors if there is nothing on the stack"
      forth
      '(("swap")))
    (test-error
      "errors if there is only one value on the stack"
      forth
      '(("1 swap")))
    (test-success
      "copies the second element if there are only two" equal?
      forth '(("1 2 over")) '(1 2 1))
    (test-success
      "copies the second element if there are more than two"
      equal? forth '(("1 2 3 over")) '(2 3 2 1))
    (test-error
      "errors if there is nothing on the stack"
      forth
      '(("over")))
    (test-error
      "errors if there is only one value on the stack"
      forth
      '(("1 over")))
    (test-success "can consist of built-in words" equal? forth
      '((": dup-twice dup dup ;" "1 dup-twice")) '(1 1 1))
    (test-success "execute in the right order" equal? forth
      '((": countup 1 2 3 ;" "countup")) '(3 2 1))
    (test-success "can override other user-defined words" equal? forth
      '((": foo dup ;" ": foo dup dup ;" "1 foo")) '(1 1 1))
    (test-success "can override built-in words" equal? forth
      '((": swap dup ;" "1 swap")) '(1 1))
    (test-success "can override built-in operators" equal? forth
      '((": + * ;" "3 4 +")) '(12))
    (test-success "can use different words with the same name" equal? forth
      '((": foo 5 ;" ": bar foo ;" ": foo 6 ;" "bar foo")) '(6 5))
    (test-success "can define word that uses word with the same name" equal?
      forth '((": foo 10 ;" ": foo foo 1 + ;" "foo")) '(11))
    (test-error "cannot redefine numbers" forth '((": 1 2 ;")))
    (test-error
      "errors if executing a non-existent word"
      forth
      '(("foo")))
    (test-success "DUP is case-insensitive" equal? forth
      '(("1 DUP Dup dup")) '(1 1 1 1))
    (test-success "DROP is case-insensitive" equal? forth
      '(("1 2 3 4 DROP Drop drop")) '(1))
    (test-success "SWAP is case-insensitive" equal? forth
      '(("1 2 SWAP 3 Swap 4 swap")) '(1 4 3 2))
    (test-success "OVER is case-insensitive" equal? forth
      '(("1 2 OVER Over over")) '(1 2 1 2 1))
    (test-success "user-defined words are case-insensitive" equal? forth
      '((": foo dup ;" "1 FOO Foo foo")) '(1 1 1 1))
    (test-success "definitions are case-insensitive" equal?
      forth '((": SWAP DUP Dup dup ;" "1 swap")) '(1 1 1 1))))

(run-with-cli "forth.scm" (list test-cases))

