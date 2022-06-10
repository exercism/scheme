
(define (run-ci exercisms)
  (for-each run-tests exercisms)
  (system "touch ci"))

(define (run-tests exercism)
  (display (format "running tests for ~a" exercism))
  (newline)
  (let* ((dir (format "exercises/practice/~a" exercism))
         (result (system
                  (format "cp input/skeleton-makefile ~a/Makefile && cd ~a && make check-all solution=.meta/example.scm"
                          dir
                          dir))))
    (unless (zero? result)
      (error 'run-ci "failed test" exercism))))

;; Run tests for all directory expect for exercises named in except.
(define (run-all-tests . except)
  (let ((blacklist
         (map (lambda (x) (if (symbol? x) (symbol->string x) x)) except)))
   (for-each run-tests
             (filter
              (lambda (x) (andmap (lambda (y) (not (equal? x y))) blacklist))
              (directory-list "exercises/practice/")))))
