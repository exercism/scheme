;; helpful procedures


;; Convenience for grabbing alist values by key
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

;; Begin Preprocessing/Helpers for process-config
;;
;; Top level helper for process-config
(define (exercises->snake-case exercises)
  (let ((handle (lambda (exercise)
                  (map format-js-pair exercise))))
    (map handle exercises)))

;; Helpers for exercises->snake-case
(define (kebab->snake str)
  (let ((k->s (lambda (c) (if (char=? c #\-) #\_ c))))
    (apply string (map k->s (string->list str)))))

(define (symbol->snake-case-string symbol)
  (kebab->snake (symbol->string symbol)))

(define (format-js-pair pair)
  (let ((snake-key (symbol->snake-case-string (car pair))))
    (if (null? (cdr pair))
        `(,snake-key)
        ;; sort the topics list
        (if (eq? 'topics (car pair))
            (cons snake-key
                  (sort string<?
                        (map symbol->snake-case-string (cdr pair))))
            ;; regular pair for everything else
            `(,snake-key . ,(cdr pair))))))
;; End Preprocessing/Helpers for make-config
