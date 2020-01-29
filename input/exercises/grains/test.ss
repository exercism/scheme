(define (parse-test test)
  (let* ((out (lookup 'expected test))
         (desc (lookup 'description test))
         (val (string->symbol (lookup 'property test)))
         (in (lookup 'input test))
         (arg (or (and (pair? in)
                       (lookup 'square in))
                  in)))
    (if (number? out)
        (if (null? arg)
            `(test-success ,desc equal? ,val '() ,out)
            `(test-success ,desc equal? ,val '(,arg) ,out))
        `(test-error ,desc ,val '(,arg)))))

(define (spec->tests spec)
  (let* ((step1 (lookup 'cases spec))
         (test-total (cdr step1))
         (test-square (car step1)))
    (append (map parse-test test-total)
            (map parse-test (lookup 'cases test-square)))))

(let ((spec (get-test-specification 'grains)))
  (put-problem!
   'grains
   `((test . ,(spec->tests spec))
     (version . ,(lookup 'version spec))
     (skeleton . "grains.scm")
     (solution . "example.scm")
     (stubs square total)
     (markdown
      .
      ,(splice-exercism 'grains
                        '(sentence "The tests expect an error to be reported for out of
range inputs."))))))


