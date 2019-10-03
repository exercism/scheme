#!chezscheme

(library (sxml)
  (export make-char-quotator
          foldts
          send-reply
          pre-post-order

          ;;
          nodeset?
          element?
          attr-list
          content-raw
          ncname
          name
          tag
          )
  (import (chezscheme))

  (define make-char-quotator
    (lambda (char-encoding)
      (lambda (S)
        (let ((n (string-length S)))
          (let loop ((b 0) (chunks '()) (a 0))
            (if (>= b n)
                (if (zero? a)
                    S
                    (reverse (cons (substring S a b) chunks)))
                (cond ((assq (string-ref S b) char-encoding)
                       => (lambda (quot)
                            (loop (1+ b)
                                  (cons* (cdr quot) (substring S a b) chunks)
                                  (1+ b))))
                      (else (loop (1+ b) chunks a)))))))))

  (define (nodeset? x)
    (or (and (pair? x)
             (not (symbol? (car x))))
        (null? x)))

  (define element?
    (lambda (obj)	
      (and (pair? obj)
           (symbol? (car obj))
           (not (memq (car obj)
                      '(@ @@ *PI* *COMMENT* *ENTITY*))))))

  (define attr-list
    (lambda (obj)
      (if (and (element? obj) 
               (not (null? (cdr obj)))
               (pair? (cadr obj))
               (eq? '@ (caadr obj)))
          (cdadr obj)
          '())))

  (define name car)
  (define tag car)

  (define ncname
    (lambda (attr)
      (symbol->string (name attr))))

  (define content-raw 
    (lambda (obj)
      ((if (and (not (null? (cdr obj)))
                (pair? (cadr obj)) (eq? (caadr obj) '@))
           (if (and (not (null? (cddr obj)))
                    (pair? (caddr obj)) (eq? (caaddr obj) '@@))
               cdddr
               cddr)
           cdr)
       obj)))

  (define send-reply
    (lambda fragments
      (let loop ((fragments fragments) (result #f))
        (cond ((null? fragments) result)
              ((not (car fragments)) (loop (cdr fragments) result))
              ((null? (car fragments)) (loop (cdr fragments) result))
              ((eq? #t (car fragments)) (loop (cdr fragments) #t))
              ((pair? (car fragments))
               (loop (cdr fragments) (loop (car fragments) result)))
              ((procedure? (car fragments))
               ((car fragments))
               (loop (cdr fragments) #t))
              (else
               (display (car fragments))
               (loop (cdr fragments) #t))))))

  (define (pre-post-order tree bindings)
    (let* ((default-binding (assq '*default* bindings))
           (text-binding (or (assq '*text* bindings) default-binding))
           (text-handler			; Cache default and text bindings
            (and text-binding
                 (if (procedure? (cdr text-binding))
                     (cdr text-binding) (cddr text-binding)))))
      (let loop ((tree tree))
        (cond ((null? tree) '())
              ((not (pair? tree))
               (let ((trigger '*text*))
                 (if text-handler
                     (text-handler trigger tree)
                     (error 'pre-post-order
                            (format "Unknown binding for ~a and no default"
                                    trigger)))))
              ;; tree is a nodelist
              ((not (symbol? (car tree)))
               (map loop tree))
              ;; tree is an SXML node
              (else
               (let* ((trigger (car tree))
                      (binding (or (assq trigger bindings)
                                   default-binding)))
                 (cond ((not binding)
                        (error 'pre-post-order
                               (format "Unknown binding for ~a and no default"
                                       trigger)))
                       ((not (pair? (cdr binding)))  ; must be a procedure: handler
                        (apply (cdr binding) trigger (map loop (cdr tree))))
                       ((eq? '*preorder* (cadr binding))
                        (apply (cddr binding) tree))
                       ((eq? '*macro* (cadr binding))
                        (loop (apply (cddr binding) tree)))
                       (else			    ; (cadr binding) is a local binding
                        (apply (cddr binding) trigger
                               (pre-post-order (cdr tree)
                                               (append (cadr binding)
                                                       bindings)))))))))))

  (define (foldts fdown fup fhere seed tree)
    (cond ((null? tree) seed)
          ;; An atom
          ((not (pair? tree))
           (fhere seed tree))
          (else
           (let loop ((kid-seed (fdown seed tree)) (kids (cdr tree)))
             (if (null? kids)
                 (fup seed kid-seed tree)
                 (loop (foldts fdown fup fhere kid-seed (car kids))
                       (cdr kids)))))))


  )
