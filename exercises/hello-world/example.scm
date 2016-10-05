(define-module (hello-world)
  #:export (hello))

(define hello
  (lambda* (#:optional name)
    (let ((target (or name "World")))
      (string-concatenate (list "Hello, " target "!")))))
