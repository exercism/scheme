
(define (parse-test test)
  `(test-success ,(lookup 'description test)
                 (lambda (xs ys)
                   (equal? (list-sort string<? xs)
                           (list-sort string<? ys)))
                 anagram
                 '(,@(map cdr (lookup 'input test)))
                 '(,@(lookup 'expected test))))

(define (spec->tests spec)
  (map parse-test (lookup 'cases spec)))

(let ((spec (get-test-specification 'anagram)))
  (put-problem!
   'anagram
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "anagram.scm")
     (solution . "example.scm")
     (stubs anagram)
     (markdown . ,(splice-exercism 'anagram '(sentence "For purposes
of this exercise, a word is not considered to be an anagram of
itself."))))))

