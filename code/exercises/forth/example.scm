(import (rnrs))

(define (forth source)
  (evaluate-forth (parse-forth source)
                  '()
                  '()))

(define (evaluate-forth program environment stack)
  (cond ((null? program) (reverse stack))
        ((eq? (caar program) 'define-forth)
         (evaluate-forth (cdr program)
                         (cons (cdar program) environment)
                         stack))
        (else
         (evaluate-forth (cdr program)
                         environment
                         (evaluate-statement (car program) environment stack)))))

;; evaluate a line of forth
(define (evaluate-statement program environment stack)
  (let walk ((program program) (stack stack))
    (cond ((null? program) stack) ;; return stack
          ((number? (car program)) ;; push
           (walk (cdr program) (cons (car program) stack)))
          ((assq (car program) environment) => ;; defn
           (lambda (def)
             (walk `(,@(cdr def) ,@(cdr program)) stack)))
          (else ;; builtin
           (case (car program)
             ((drop) (walk (cdr program) (cdr stack)))
             ((dup) (walk (cdr program) `(,(car stack) ,@stack)))
             ((*) (walk (cdr program) `(,(* (car stack) (cadr stack)) ,@(cddr stack))))
             ((+) (walk (cdr program) `(,(+ (car stack) (cadr stack)) ,@(cddr stack))))
             ((-) (walk (cdr program) `(,(- (car stack) (cadr stack)) ,@(cddr stack))))
             ((/) (walk (cdr program) `(,(/ (car stack) (cadr stack)) ,@(cddr stack))))
             (else (error 'evaluate-statement "todo")))))))

(define (parse-forth source)
  (define (parse-statement statement)
    (define (definition? line)
      (and (< 2 (string-length line))
           (char=? (string-ref line 0)
                   #\:)
           (char=? (string-ref line (- (string-length line) 1))
                   #\;)))
    (define (parse-definition stmt)
      `(define-forth
         ,@(parse-statement
            (substring stmt 1 (- (string-length stmt) 1)))))
    (define (parse-line stmt)
      (with-input-from-string
       stmt
       (lambda ()
         (let loop ((next (read)) (tokens '()))
           (if (eof-object? next)
               (reverse tokens)
               (loop (read) (cons next tokens)))))))
    (if (definition? statement)
        (parse-definition statement)
        (parse-line statement)))
  (map parse-statement source))

