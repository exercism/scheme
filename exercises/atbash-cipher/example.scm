(define-module (atbash-cipher)
  #:autoload (srfi srfi-26) (cut)
  #:autoload (srfi srfi-1) (iota)
  #:autoload (ice-9 regex) (regexp-substitute/global
                            list-matches)
  #:export (encode decode))

;; "zip" a...z and z...a together to create an alist of mappings.
(define alphamap
  (let* ((alpha (map integer->char (iota 26 (char->integer #\a)))))
    (map cons alpha (reverse alpha))))

;; Look up the given character in the alphamap and return its complement.
(define (convert-char chr)
  (or (assoc-ref alphamap chr) chr))

;; Encode the given "val" string using the Atbash cipher.
(define (encode val)
  (format-atbash (string-map convert-char (prepare-input val))))

;; Decode the given Atbash cipher.
(define (decode val)
  (string-map convert-char (prepare-input val)))

;; Filter any unprocessable characters out of the plain text.
;; Only lowercase a-z and 0-9 are allowed.
(define (prepare-input val)
  (regexp-substitute/global #f "[^a-z0-9]" (string-downcase val) 'pre "" 'post))

;; Format atbash ciphertext for output.
;; Add a space every 5 characters
;; Currently generates a preceeding space, which must be trimmed :(
(define (format-atbash val)
  (string-trim
   (string-concatenate
    (map (compose (cut string-append " " <>)
                  match:substring)
         (list-matches "[a-z0-9]{1,5}" val)))))


