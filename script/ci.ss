
(define (run-ci exercisms)
  (for-each run-tests exercisms)
  (system "touch ci"))

(define (run-tests exercism)
  (let* ((dir (format "exercises/practice/~a" exercism))
         (result (system
                  (format "cp input/skeleton-makefile ~a/Makefile && cd ~a && make check-all solution=.meta/example.scm"
                          dir
                          dir))))
    (unless (zero? result)
      (error 'run-ci "failed test" exercism))))

(define (run-all-tests)
  (for-each run-tests (directory-list "exercises/practice/")))
