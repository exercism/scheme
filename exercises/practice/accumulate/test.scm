(load "test-util.ss")

(define (string-reverse s)
  (list->string (reverse (string->list s))))

(define (identity x) x)

(define (string-join xs sep)
  (if (null? xs) ""
      (fold-left (lambda (r x)
                    (string-append r (string-append sep x)))
                  (car xs) (cdr xs))))

(define (square x) (* x x))

(define test-cases
  '((test-success "empty list" equal? accumulate
      `(,identity ()) '())
     (test-success "identity" equal? accumulate
       `(,identity (1 2 3)) '(1 2 3))
     (test-success "1+" equal? accumulate `(,1+ (1 2 3))
       '(2 3 4))
     (test-success "squares" equal? accumulate `(,square (1 2 3))
       '(1 4 9))
     (test-success "upcases" equal? accumulate
       `(,string-upcase ("hello" "world")) '("HELLO" "WORLD"))
     (test-success "reverse strings" equal? accumulate
       `(,string-reverse
          ("the" "quick" "brown" "fox" "jumps" "over" "the" "lazy"
            "dog"))
       '("eht" "kciuq" "nworb" "xof" "spmuj" "revo" "eht" "yzal"
          "god"))
     (test-success "length" equal? accumulate
       `(,length ((a b c) (((d))) (e (f (g (h)))))) '(3 1 2))
     (test-success "accumulate w/in accumulate" equal? accumulate
       `(,(lambda (x)
            (string-join
              (accumulate (lambda (y) (string-append x y)) '("1" "2" "3"))
              " "))
          ("a" "b" "c"))
       '("a1 a2 a3" "b1 b2 b3" "c1 c2 c3"))))

(run-with-cli "accumulate.scm" (list test-cases))
