(define (parse-test test)
  (let* ((proc (string->symbol (lookup 'property test)))
         (input (lookup 'input test))
         (key (lookup 'key input))
         (phrase (lookup 'phrase input))
         (expected (lookup 'expected test)))
    (if (string? expected)
        `(test-success ,(lookup 'description test) equal? ,proc
                       '(,key ,phrase) ,expected)
        `(test-error ,(lookup 'description test) ,proc '(,key ,phrase)))))

(define (spec->tests spec)
  (let* ((cases (lookup 'cases spec))
         (encoding (lookup 'cases (car cases)))
         (decoding (lookup 'cases (cadr cases))))
    (map parse-test (append encoding decoding))))

(let ([spec (get-test-specification 'affine-cipher)])
  (put-problem!
    'affine-cipher
    `((test . ,(spec->tests spec))
       (version lookup 'version spec)
       (skeleton . ,"affine-cipher.scm")
       (solution . ,"example.scm")
       (stubs encode decode)
       (markdown
        .
        ,(splice-exercism 'affine-cipher
                          '(sentence "Creating an assoc list of the alphabet and the cipherbet is an easy way to avoid implementing the full decryption algorithm."))))))
