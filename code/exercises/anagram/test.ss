;; spec->tests takes an sexpression version of the json from the
;; exercism/problem-specifications repository, and turns it into part of the
;; eventual test suite for the exercise.
;;
;; The general form of the specification has the test cases under key 'cases, so
;; in many cases the simplest thing works, (lookup 'cases spec). Otherwise, the
;; spec will have to be searched to get the appropriate test cases and to pass
;; them to parse-test.
;;
;; parse-test takes one of these cases and turns it into a thunk that will be
;; run as a test by the exercise/test.scm file. It is important that the input
;; argument be a quoted list, as the test suite will call (apply procedure
;; input) to run the test. The output of this is compared against the expected
;; result from the spec, by a specified equality predicate. Here, that is to
;; sort the list of strings so order doesn't matter in the solution.
(define (parse-test test)
  `(lambda ()
     (test-success ,(lookup 'description test)
		   (lambda (xs ys)
		     (equal? (list-sort string<? xs)
			     (list-sort string<? ys)))
		   anagram
		   '(,@(map cdr (lookup 'input test)))
		   '(,@(lookup 'expected test)))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply run-test-suite
	     (list ,@(map parse-test (lookup 'cases spec)))
	     args))))

(let ((spec (get-test-specification 'anagram)))
  (put-problem!
   'anagram
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "anagram.scm")
     (solution . "example.scm")
     (hints.md
      .
      ,(md-hints
        `((sentence "For purposes of this exercise, a word is not
considered to be an anagram of itself.")))))))

