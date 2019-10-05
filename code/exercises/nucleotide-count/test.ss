(define (parse-test test)
  (let ((expected (lookup 'expected test))
        (in (cdar (lookup 'input test)))
        (desc (lookup 'description test)))
    (if (eq? 'error (caar expected))
        `(test-error ,desc nucleotide-count '(,in))
        `(test-success ,desc
                       (lambda (xs ys)
                         (letrec ((make-list
                                   (lambda (x n)
                                     (if (zero? n)
                                         '()
                                         (cons x (make-list x (- n 1))))))
                                  (count->list
                                   (lambda (z)
                                     (list-sort char<?
                                                (apply append (map (lambda (x)
                                                                     (make-list (car x) (cdr x)))
                                                                   z))))))
                           (equal? (count->list xs) (count->list ys))))
                       nucleotide-count
                       '(,in)
                       '(,@(map (lambda (x) ;; make sure cars are chars not symbols
                                  (cons (string-ref (symbol->string (car x)) 0)
                                        (cdr x)))
                                expected))))))

(define (spec->tests spec)
  (map parse-test
       (lookup 'cases
               (cdar
                (lookup 'cases spec)))))

(let ((spec (get-test-specification 'nucleotide-count)))
  (put-problem!
   'nucleotide-count
   `((test . ,(spec->tests spec))
     (stubs nucleotide-count)
     (version . ,(lookup 'version spec))
     (skeleton . "nucleotide-count.scm")
     (solution . "example.scm")
     (hints.md . ,(splice-exercism 'nucleotide-count)))))

