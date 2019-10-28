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

(define anagram)

(define (test . query)
  (apply
    run-test-suite
    (list
      (lambda ()
        (test-success "no matches"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("diaper" ("hello" "world" "zombies" "pants"))
          '()))
      (lambda ()
        (test-success "detects two anagrams"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("master" ("stream" "pigeon" "maters"))
          '("stream" "maters")))
      (lambda ()
        (test-success "does not detect anagram subsets"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("good" ("dog" "goody")) '()))
      (lambda ()
        (test-success "detects anagram"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("listen" ("enlists" "google" "inlets" "banana"))
          '("inlets")))
      (lambda ()
        (test-success "detects three anagrams"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram
          '("allergy"
             ("gallery" "ballerina" "regally" "clergy" "largely"
               "leading"))
          '("gallery" "regally" "largely")))
      (lambda ()
        (test-success "detects multiple anagrams with different case"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("nose" ("Eons" "ONES")) '("Eons" "ONES")))
      (lambda ()
        (test-success "does not detect non-anagrams with identical checksum"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("mass" ("last")) '()))
      (lambda ()
        (test-success "detects anagrams case-insensitively"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram
          '("Orchestra" ("cashregister" "Carthorse" "radishes"))
          '("Carthorse")))
      (lambda ()
        (test-success "detects anagrams using case-insensitive subject"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram
          '("Orchestra" ("cashregister" "carthorse" "radishes"))
          '("carthorse")))
      (lambda ()
        (test-success "detects anagrams using case-insensitive possible matches"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram
          '("orchestra" ("cashregister" "Carthorse" "radishes"))
          '("Carthorse")))
      (lambda ()
        (test-success
          "does not detect an anagram if the original word is repeated"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("go" ("go Go GO")) '()))
      (lambda ()
        (test-success "anagrams must use all letters exactly once"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("tapper" ("patter")) '()))
      (lambda ()
        (test-success "words are not anagrams of themselves (case-insensitive)"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("BANANA" ("BANANA" "Banana" "banana")) '()))
      (lambda ()
        (test-success "words other than themselves can be anagrams"
          (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
          anagram '("LISTEN" ("Listen" "Silent" "LISTEN"))
          '("Silent"))))
    query))

(let ([args (command-line)])
  (if (null? (cdr args))
      (load "anagram.scm")
      (load (cadr args)))
  (test 'input 'output))

