(import (rnrs)
        (rnrs arithmetic bitwise))

(define (sieve N)
  (cond ((> N 4) (run-eratosthenes N))
        (else (filter (lambda (p)
                        (<= p N))
                      '(2 3)))))

(define (run-eratosthenes N)
  (define bits (eratosthenes-sieve N))
  (define (walk k dk) ;; alternate dk = 2 or 4
    (cond ((> k N) '())
          ((u8:prime? bits k) (cons k (walk (+ k dk) (- 6 dk))))
          (else (walk (+ k dk) (- 6 dk)))))
  (cons* 2 3 (walk 5 2)))

(define (eratosthenes-sieve N)
  (define cutoff (1+ (u8:column N)))
  (define bits (make-bytevector cutoff 255))
  (define (clear 2*p j)
    (unless (> j N)
      (u8:clear bits j)
      (clear 2*p (+ 2*p j))))
  (define (sieve p)
    (unless (> (* p p) N)
      (when (u8:prime? bits p)
        (clear (ash p 1) (* p p)))
      (sieve (+ p 2))))
  (sieve 3)
  bits)

;; help for dealing with bitvector
(define (u8:column n)
  (ash n -3))

(define (u8:row n)
  (logand n 7))

(define (u8:index n)
  (values (u8:column n) (u8:row n)))

(define (u8:prime? V j)
  (let-values (((c r) (u8:index j)))
    (bitwise-bit-set? (bytevector-u8-ref V c) r)))

(define (u8:clear V j)
  (let-values (((c r) (u8:index j)))
    (let ((x (bytevector-u8-ref V c)))
      (bytevector-u8-set! V c (logand x (bitwise-not (ash 1 r)))))))

(define (u8:mark V j)
  (let-values (((c r) (u8:index j)))
    (let ((x (bytevector-u8-ref V c)))
      (bytevector-u8-set! V c (logior x (ash 1 r))))))

