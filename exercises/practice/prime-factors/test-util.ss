(import (except (rnrs) current-output-port))

(define test-fields '(input expected actual))

(define (test-run-solution solution input)
  (if (procedure? solution) (apply solution input) solution))

(define (scheme->string o)
  (with-output-to-string
    (lambda ()
      (write o))))

(define (process-condition e)
  (if (not (condition? e)) e
      `(error
        ,(if (who-condition? e) (condition-who e)
             'unknown)
        ,(condition-message e)
        ,@(map scheme->string
               (if (not (irritants-condition? e)) '()
                   (condition-irritants e))))))

(define (test-success description success-predicate
                      procedure input expected code)
  (call/cc
   (lambda (k)
     (let ([out (open-output-string)])
       (dynamic-wind
         (lambda () (set! out (open-output-string)))
         (lambda ()
           (with-exception-handler
               (lambda (e)
                 (k `(fail
                      (description . ,description)
                      (code . ,code)
                      (input . ,input)
                      (expected . ,expected)
                      (actual . ,(process-condition e))
                      (stdout . ,(get-output-string out)))))
             (lambda ()
               (let ([result (parameterize ([current-output-port out])
                               (test-run-solution procedure input))])
                 (unless (success-predicate result expected)
                   (raise result))
                 `(pass
                   (description . ,description)
                   (code . ,code)
                   (stdout . ,(get-output-string out)))))))
         (lambda () (close-output-port out)))))))

(define (test-error description procedure input code)
  (call/cc
    (lambda (k)
      (let ([out '()])
        (dynamic-wind
          (lambda () (set! out (open-output-string)))
          (lambda ()
            (with-exception-handler
                (lambda (e)
                  (k `(pass
                       (description . ,description)
                       (code . ,code)
                       (stdout . ,(get-output-string out)))))
              (lambda ()
                (let ((result (parameterize ([current-output-port out])
                                (test-run-solution procedure input))))
                  `(fail
                    (description . ,description)
                    (code . ,code)
                    (input . ,input)
                    (expected . error)
                    (actual . ,result)
                    (stdout . ,(get-output-string out)))))))
          (lambda () (close-output-port out)))))))

(define (run-test test)
  (eval (append test `((quote ,test))) (interaction-environment)))

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
                  (map run-test tests))])
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


(define (run-docker suite)
  (write (map run-test suite)))

(define (test suite . query)
  (apply run-test-suite suite query))

(define (tests suites . query)
  (for-each (lambda (suite) (apply test suite query)) suites))

(define (run-with-cli solution suites)
  (let ((args (command-line)))
    (cond
     ;; Normal execution.  This is the default behavior used by students
     ;; running their tests locally.
     [(null? (cdr args))
      (load solution)
      (tests suites 'input 'expected 'actual)]
     ;; Scheme programs ingesting this output can expect an alist with
     ;; the keys 'test-lib-version and 'status.  No test-lib version
     ;; means an older version of these test utilities is in use, so there
     ;; will only be pass/fail lists in the output.  When status is 'error,
     ;; A message is provided for explanation. It is usually a stringified
     ;; condition.  When status is 'completed everything is normal, and the
     ;; rest of the list comsists of pass/fail lists.
     [(string=? (cadr args) "--docker")
      (write
       `((test-lib-version . 1)
         ,@(call/cc
            (lambda (k)
              (with-exception-handler
                  ;; Catch failures while loading/compiling the solution.
                  (lambda (e)
                    (k `((status . error)
                         (message
                          . ,(string-append
                              "Failed with value: "
                              (scheme->string (process-condition e)))))))
                (lambda ()
                  (load solution)
                  `((status . ok)
                    ,@(fold-left (lambda (results suite)
                                   (append results (map run-test suite)))
                                 '()  suites))))))))]
     ;; You can pass the name of a file to load instead of the "expected" solution filename.
     [else (load (cadr args)) (tests suites 'input 'expected 'actual)])))
