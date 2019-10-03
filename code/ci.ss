
(define (run-ci exercisms)
  (for-each run-tests exercisms)
  (with-output-to-file "ci"
    (lambda ()
      (display 'success) (newline))))

(define (run-tests exercism)
  (let* ((dir (format "exercises/~a" exercism))
         (result (system (format "cp code/stub-makefile ~a/Makefile && cd ~a && make && rm Makefile"
                                 dir
                                 dir))))
    (unless (zero? result)
      (error 'run-ci "failed test" exercism))))

