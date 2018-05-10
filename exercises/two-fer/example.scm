(define-module (two-fer)
  #:export (two-fer))

(define two-fer
  (lambda* (#:optional name)
    (let ((target (or name "you")))
      (string-concatenate (list "One for " target ", one for me.")))))
