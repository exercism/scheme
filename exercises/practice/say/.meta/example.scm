(import (rnrs))

(define (pronounce number)
  (let ((singles '#("zero" "one" "two" "three" "four"
                    "five" "six" "seven" "eight" "nine"
                    "ten" "eleven" "twelve" "thirteen" "fourteen"
                    "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"))
        (decades '#("zero" "ten" "twenty" "thirty" "forty"
                    "fifty" "sixty" "seventy" "eighty" "ninety")))
    (cond
      ((zero? number)
        '())
      ((< number 20)
        (list (vector-ref singles number)))
      ((zero? (remainder number 10))
        (list (vector-ref decades (quotient number 10))))
      (else
        (list (string-append (vector-ref decades (quotient number 10))
                             "-"
                             (vector-ref singles (remainder number 10))))))))

(define (describe number place)
  (cond
    ((zero? number)
      '())
    ((< number 100)
      (append (pronounce number) place))
    (else
      (append (pronounce (quotient number 100))
              (list "hundred")
              (pronounce (remainder number 100))
              place))))

(define (say number)
  (when (or (< number 0) (<= 1000000000000 number))
    (error 'number "input out of range" number))
  (if (zero? number)
    "zero"
    (let* ((billions (quotient number 1000000000))
           (millions (remainder (quotient number 1000000) 1000))
           (thousands (remainder (quotient number 1000) 1000))
           (units (remainder number 1000)))
      (string-join (append (describe billions (list "billion"))
                           (describe millions (list "million"))
                           (describe thousands (list "thousand"))
                           (describe units '()))))))
