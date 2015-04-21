(define-module (robot)
  #:export (build-robot
            robot-name
            reset-robot)
  #:autoload (srfi srfi-1) (iota))

(define random-alpha-char
  (lambda ()
    (list-ref (map integer->char (iota 26 65)) (random 26))))

(define random-digit-char
  (lambda ()
    (list-ref (map integer->char (iota 10 48)) (random 10))))

(define gen-name
  (lambda ()
    (string
     (random-alpha-char)
     (random-alpha-char)
     (random-digit-char)
     (random-digit-char)
     (random-digit-char))))

(define build-robot
  (lambda ()
    (let ((robot (make-hash-table 2)))
      (hashq-create-handle! robot 'name  (gen-name))
      robot)))



(define robot-name
  (lambda (robot)
    (hashq-ref robot 'name)))

(define reset-robot
  (lambda (robot)
    (set! robot (hashq-set! robot 'name (gen-name)))))
