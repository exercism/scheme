(import (chezscheme))

(define (read-all-map-maybe p src)
  (with-input-from-file src
    (lambda ()
      (let rec ((ys '()))
        (let ((x (read)))
          (if (eof-object? x) ys
              (let ((y (p x)))
                (rec (if y (cons y ys) ys)))))))))

(define (definition? x)
  (and (list? x)
       (>= (length x) 2)
       (equal? (car x) 'define)))

(define (stub? x)
  (and (definition? x) (= (length x) 2)))

(define (definition-name? name def)
  (let ((ident (cadr def)))
    (cond
     ((symbol? ident) (equal? name ident))
     ((pair? ident) (equal? name (car ident)))
     (else #f))))

(define (test-runner? x)
  (and (list? x) (= 3 (length x))
       (equal? (car x) 'let)
       (equal? (cadr x) '((args (command-line))))))

(define (legacy-import? x)
  (equal? x '(import (except (rnrs) current-output-port))))

;; Predicate for things that should still be in the test.scm file.
;; This includes things we don't know about like extra predicates for the tests.
;; That is why it is defined in the negative.
(define (relevant? x)
  (not (obsolete? x)))

;; Predicate for all the things that shouldn't be in
;; the test.scm file anymore.
(define (obsolete? x)
  (or (stub? x)
      (test-runner? x)
      (legacy-import? x)
      (definition-name? 'test x)
      (definition-name? 'run-docker x)
      (definition-name? 'run-test-suite x)
      (definition-name? 'test-error x)
      (definition-name? 'test-success x)
      (definition-name? 'test-run-solution x)
      (definition-name? 'test-fields x)))


(define load-statement '(load "test-util.ss"))
(define (test-statement slug)
  `(run-with-cli ,(format "~a.scm" slug) (list test-cases)))

(define (migrate-test-cases cases)
  (unless (definition-name? 'test-cases cases)
    (error 'migrate-test-cases
           "~s is not the test-cases definition" cases))
  `(define test-cases
     ,(list 'quasiquote (map caddr (cdaddr cases)))))

(define (cdr-or x y)
  (if (pair? x) (cdr x) y))

;; We end up with 2 trailing newlines.
(define (migrate-file src . args)
  (let ((slug (cdr-or (assoc 'slug args) 'solution))
        (body-parts
         (read-all-map-maybe
          (lambda (x)
            (and (relevant? x)
                 (if (definition-name? 'test-cases x)
                     (migrate-test-cases x)
                     x)))
          src)))
    (delete-file src)
    (with-output-to-file src
      (lambda ()
        (for-each
         (lambda (x) (pretty-print x) (newline))
         (cons load-statement
               (reverse
                (cons (test-statement slug)
                      body-parts))))))))

(define (slug->directory slug . args)
  (let ((kind (cdr-or (assoc 'kind args) 'practice)))
   (format "exercises/~a/~a/" kind slug)))

(define (append-path base ext)
  (unless (char=? #\/ (string-ref base (1- (string-length base))))
    (set! base (string-append base "/")))
  (format "~a~a" base ext))

(define (filename path)
  (let ((last-sep-idx
         (fold-left
          (lambda (last x)
            (or (and (char=? #\/ (cdr x)) (car x))
                last))
          #f (map cons (iota (string-length path))
                  (string->list path)))))
    (if (not last-sep-idx) path
        (substring path (1+ last-sep-idx) (string-length path)))))

(define (copy-file from to)
  (when (file-directory? to)
    (set! to (append-path to (filename from))))
  (when (file-exists? to)
    (delete-file to))
  (with-input-from-file from
    (lambda ()
      (with-output-to-file to
        (lambda ()
          (do ((chunk (get-string-n (current-input-port) 1024)
                      (get-string-n (current-input-port) 1024)))
              ((eof-object? chunk))
            (put-string (current-output-port) chunk)))))))

(define (migrate-exercise slug . args)
  (let* ((kind (cdr-or (assoc 'kind args) 'practice))
         (dir (slug->directory slug `(kind . ,kind))))
    (copy-file "input/test-util.ss" dir)
    (migrate-file (append-path dir "test.scm") `(slug . ,slug))))

(define (deploy-new-test-util)
  (for-each
   (lambda (slug)
     (copy-file "input/test-util.ss"
                (slug->directory slug)))
   (directory-list "exercises/practice/")))
