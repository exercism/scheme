
(define (parse-test test)
  (let* ((out (lookup 'expected test))
         (desc (lookup 'description test))
         (input (lookup 'input test))
         (strand1 (lookup 'strand1 input))
         (strand2 (lookup 'strand2 input)))
    ;; if not number test expects error
    (if (number? out)
        `(test-success ,desc
                       =
                       hamming-distance
                       '(,strand1 ,strand2)
                       ,out)
        `(test-error ,desc
                     hamming-distance
                     '(,strand1 ,strand2)))))

(define (spec->tests spec)
  (map parse-test (lookup 'cases spec)))

(let ((spec (get-test-specification 'hamming)))
  (put-problem!
   'hamming
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "hamming.scm")
     (solution . "example.scm")
     (stubs hamming-distance)
     (markdown
      .
      ,(splice-exercism 'hamming
                        '(sentence "For scheme, you may want to look into one of "
                                   (inline-code "error")
                                   ", "
                                   (inline-code "assert")
                                   ", or "
                                   (inline-code "raise")
                                   "."))))))

