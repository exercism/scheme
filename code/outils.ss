;; helpful procedures

(define (lookup key alist)
  (cond ((assoc key alist) => cdr)
	(else (error 'lookup "key not in alist" key alist))))

(define (lookup-partial key)
  (lambda (alist)
    (lookup key alist)))

(define (lookup-spine keys alist)
  (fold-left (lambda (alist key)
	       (lookup key alist))
	     alist
	     keys))

(define (read-all)
  (let loop ((sexp (read)) (config '()))
    (if (eof-object? sexp)
	(reverse config)
	(loop (read) (cons sexp config)))))

(define (write-expression-to-file code file)
  (when (file-exists? file)
    (delete-file file))
  (with-output-to-file file
    (lambda ()
      (for-each (lambda (line)
		  (pretty-print line) (newline))
		code))))

(define (update-config)
  (load "code/config.ss"))




