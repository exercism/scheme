(define-module (phone-number)
  #:export (numbers area-code pprint))


(define (strip-non-digits str)
  (string-filter char-numeric? str))

(define (trim-leading-one str)
  (if (and (= 11 (string-length str))
           (char=? #\1 (car (string->list str))))
      (substring str 1)
      str))

(define (ensure-valid str)
  (if (= 10 (string-length string))
      str
      "0000000000"))

(define (numbers number-string)
  )
