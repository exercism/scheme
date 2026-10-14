(import (rnrs))

(define (suffix number)
  (let ((units (remainder number 10))
        (tens (remainder (quotient number 10) 10)))
    (cond
      ((= 1 tens) "th")
      ((= 1 units) "st")
      ((= 2 units) "nd")
      ((= 3 units) "rd")
      (else "th"))))

(define (format-message name number)
  (string-append name
                 ", you are the "
                 (number->string number)
                 (suffix number)
                 " customer we serve today. Thank you!"))
