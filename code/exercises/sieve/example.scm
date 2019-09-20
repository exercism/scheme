
(define (sieve N)
  (cond ((> N 4) (run-eratosthenes N))
        (else (filter (lambda (p)
                        (<= p N))
                      '(2 3)))))

(define (run-eratosthenes N)
  (define bits (eratosthenes-sieve N))
  (define (walk k dk) ;; alternate dk = 2 or 4
    (cond ((fx> k N) '())
          ((u8:prime? bits k) (cons k (walk (fx+ k dk) (fx- 6 dk))))
          (else (walk (fx+ k dk) (fx- 6 dk)))))
  (cons* 2 3 (walk 5 2)))

(define (eratosthenes-sieve N)
  (define cutoff (fx1+ (u8:column N)))
  (define bits (make-bytevector cutoff 255))
  (define (clear 2*p j)
    (unless (fx> j N)
      (u8:clear bits j)
      (clear 2*p (fx+ 2*p j))))
  (define (sieve p)
    (unless (fx> (fx* p p) N)
      (when (u8:prime? bits p)
        (clear (fxsll p 1) (fx* p p)))
      (sieve (fx+ p 2))))
  (sieve 3)
  bits)

;; help for dealing with bitvector
(define (u8:column n)
  (fxsrl n 3))

(define (u8:row n)
  (fxlogand n 7))

(define (u8:index n)
  (values (u8:column n) (u8:row n)))

(define (u8:prime? V j)
  (let-values (((c r) (u8:index j)))
    (fxlogbit? r (bytevector-u8-ref V c))))

(define (u8:clear V j)
  (let-values (((c r) (u8:index j)))
    (let ((x (bytevector-u8-ref V c)))
      (bytevector-u8-set! V c (fxlogbit0 r x)))))

(define (u8:mark V j)
  (let-values (((c r) (u8:index j)))
    (let ((x (bytevector-u8-ref V c)))
      (bytevector-u8-set! V c (fxlogbit1 r x)))))

