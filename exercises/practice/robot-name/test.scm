(load "test-util.ss")

(define *robbie* (build-robot))

(define *clutz* (build-robot))


(define (any f xs)
  (fold-left (lambda (r x) (or r (f x))) #f xs))

(define (every f xs)
  (fold-left (lambda (r x) (and r (f x))) #t xs))

(define (string-any f s)
  (any f (string->list s)))

(define (string-every f s)
  (every f (string->list s)))


(test-assert
  "name matches expected pattern"
  (let ([name (robot-name *robbie*)])
    (and (eq? (string-length name) 5)
         (string-every char-upper-case? (substring name 0 2))
         (string-every char-numeric? (substring name 2 5)))))

(test-equal
  "name is persistent"
  (robot-name *robbie*)
  (robot-name *robbie*))

(test-assert
  "different robots have different names"
  (not (string=? (robot-name *robbie*) (robot-name *clutz*))))

(test-assert
  "name can be reset"
  (let* ([robot (build-robot)]
         [original-name (robot-name robot)])
    (reset-name robot)
    (not (string=? (robot-name robot) original-name))))

(define (robot-name? name)
  (and (= (string-length name) 5)
       (string-every char-upper-case? (substring name 0 2))
       (string-every char-numeric? (substring name 2 5))))

(define test-cases
  `((test-success "name matches expected pattern"
                  (lambda ()))))

(run-with-cli "robot-name.scm" (list test-cases))
