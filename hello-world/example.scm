(define-module (hello-world)
  #:export (hello))

(define hello
  (lambda* (#:optional name)
    (let ((target (or name "world")))
      (string-concatenate (list "Hello, " target "!")))))
