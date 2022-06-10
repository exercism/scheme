(load "test-util.ss")

(define test-cases
  `((test-success "empty strand"
      (lambda (xs ys)
        (letrec ([make-list (lambda (x n)
                              (if (zero? n)
                                  '()
                                  (cons x (make-list x (- n 1)))))]
                 [count->list (lambda (z)
                                (list-sort
                                  char<?
                                  (apply
                                    append
                                    (map (lambda (x)
                                           (make-list (car x) (cdr x)))
                                         z))))])
          (equal? (count->list xs) (count->list ys))))
      nucleotide-count '("")
      '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0)))
     (test-success "can count one nucleotide in single-character input"
       (lambda (xs ys)
         (letrec ([make-list (lambda (x n)
                               (if (zero? n)
                                   '()
                                   (cons x (make-list x (- n 1)))))]
                  [count->list (lambda (z)
                                 (list-sort
                                   char<?
                                   (apply
                                     append
                                     (map (lambda (x)
                                            (make-list (car x) (cdr x)))
                                          z))))])
           (equal? (count->list xs) (count->list ys))))
       nucleotide-count '("G")
       '((#\A . 0) (#\C . 0) (#\G . 1) (#\T . 0)))
     (test-success "strand with repeated nucleotide"
       (lambda (xs ys)
         (letrec ([make-list (lambda (x n)
                               (if (zero? n)
                                   '()
                                   (cons x (make-list x (- n 1)))))]
                  [count->list (lambda (z)
                                 (list-sort
                                   char<?
                                   (apply
                                     append
                                     (map (lambda (x)
                                            (make-list (car x) (cdr x)))
                                          z))))])
           (equal? (count->list xs) (count->list ys))))
       nucleotide-count '("GGGGGGG")
       '((#\A . 0) (#\C . 0) (#\G . 7) (#\T . 0)))
     (test-success "strand with multiple nucleotides"
       (lambda (xs ys)
         (letrec ([make-list (lambda (x n)
                               (if (zero? n)
                                   '()
                                   (cons x (make-list x (- n 1)))))]
                  [count->list (lambda (z)
                                 (list-sort
                                   char<?
                                   (apply
                                     append
                                     (map (lambda (x)
                                            (make-list (car x) (cdr x)))
                                          z))))])
           (equal? (count->list xs) (count->list ys))))
       nucleotide-count
       '("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
       '((#\A . 20) (#\C . 12) (#\G . 17) (#\T . 21)))
     (test-error
       "strand with invalid nucleotides"
       nucleotide-count
       '("AGXXACT"))))

(run-with-cli "nucleotide-count.scm" (list test-cases))

