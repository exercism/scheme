
(define (forth source)
  (evaluate-forth (parse-forth source) '() '()))

(define (evaluate-forth program environment stack)
  (cond ((null? program) stack)
        ((eq? 'define-forth (caar program))
         (evaluate-forth (cdr program)
                         (define-forth (cdar program) environment)
                         stack))
        (else
         (evaluate-forth (cdr program)
                         environment
                         (evaluate-statement (car program) environment stack)))))

(define (define-forth atoms environment)
  (let ((symbol (car atoms)))
    (assert (not (number? symbol)))
    `((,symbol ,@(fold-right (lambda (atom definition)
                               (cond ((assq atom environment)
                                      => (lambda (def)
                                           `(,@(cdr def) ,@definition)))
                                     (else (cons atom definition))))
                             '()
                             (cdr atoms)))
      ,@environment)))

;; evaluate a line of forth
(define (evaluate-statement statement environment stack)
  (let walk ((statement statement) (stack stack))
    (cond
     ((null? statement) stack) ;; return stack
     ((number? (car statement)) ;; push number to stack
      (walk (cdr statement) (cons (car statement) stack)))
     ((assq (car statement) environment) ;; substitute definition
      => (lambda (def)
           (walk `(,@(cdr def) ,@(cdr statement)) stack)))
     (else ;; builtins
      (case (car statement)
        ((drop) (walk (cdr statement) (cdr stack)))
        ((dup) (walk (cdr statement) `(,(car stack) ,@stack)))
        ((over) (walk (cdr statement) `(,(cadr stack) ,@stack)))
        ((swap) (walk (cdr statement) `(,(cadr stack),(car stack) ,@(cddr stack))))
        ((*) (walk (cdr statement) `(,(* (cadr stack) (car stack)) ,@(cddr stack))))
        ((+) (walk (cdr statement) `(,(+ (cadr stack) (car stack)) ,@(cddr stack))))
        ((-) (walk (cdr statement) `(,(- (cadr stack) (car stack)) ,@(cddr stack))))
        ((/) (walk (cdr statement) `(,(quotient (cadr stack) (car stack)) ,@(cddr stack))))
        (else (error 'forth "unknown thing" statement environment stack)))))))

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
       (string-downcase stmt)
       (lambda ()
         (let loop ((next (read)) (tokens '()))
           (if (eof-object? next)
               (reverse tokens)
               (loop (read) (cons next tokens)))))))
    (if (definition? statement)
        (parse-definition statement)
        (parse-line statement)))
  (map parse-statement source))

