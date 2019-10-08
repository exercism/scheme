(import (rnrs))


(define (encode key text)
  ((get-translator key) (string-downcase text) 'encode))

(define (decode key text)
  ((get-translator key) text 'decode))

;;; Private

(define (atbash-format lst)
  (let* ((chunks (windows lst 5))
         (l (cons (car chunks)
                  (map (lambda (chars) (cons #\space chars))
                       (cdr chunks)))))
    (list->string (fold-left append '() l))))

(define (get-translator key)
  (let ((a (car key))
        (b (cdr key)))
  (when (not (coprime? a 26))
    (error 'affine-cipher "a and m must be coprime" a))
  (translator-factory a b)))

;; Work Horse - return a translator tuned to a specific affine key
(define (translator-factory a b)
  (let* (;; generate a char pair from an alphabetic index
         (index->pair
          (lambda (idx)            ;; (a * x + b) % m
            (let ((cipher-idx (modulo (+ (* a idx) b) 26)))
              `(,(idx->char idx) . ,(idx->char cipher-idx)))))
         ;; build an alist mapping the alphabet to the 'cipherbet'
         (encode-map (map index->pair (iota 26)))
         ;; build an alist mapping the 'cipherbet' to the alphabet
         (decode-map (map riap encode-map))
         ;; en/decrypt text and return a char list
         (translate
          (lambda (text tr-map)
            (filter
             ;; identity - to remove #f from the list
             (lambda (x) x)
             (map (lambda (c)
                    (cond ((assoc c tr-map) => cdr)
                          ((char-numeric? c) c)
                          (else #f)))
                  (string->list text))))))
    (lambda (text msg)
      (case msg
        ((encode) (atbash-format (translate text encode-map)))
        ((decode) (list->string (translate text decode-map)))
        (else (error 'translator-factory "invalid message" msg))))))

;;; Generic Helper Functions

(define (coprime? x y)
  (= 1 (gcd x y)))

(define (idx->char idx)
  (integer->char (+ idx (char->integer #\a))))

(define (riap pair)
  (when (not (pair? pair))
    (error 'riap "wrong type arg is not a pair" pair))
  (cons (cdr pair) (car pair)))

(define (windows lst size)
  (let windows* ((l lst) (acc '()))
    (if (>= (length l) size)
        (let ((window (list-head l size)))
          (windows* (list-tail l size) (cons window acc)))
        (if (null? l)
            (reverse acc)
            (reverse (cons l acc))))))
