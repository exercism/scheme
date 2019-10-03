(define-module (bob)
  #:export (response-for))

(define shouting?
  (lambda (phrase)
    (and (string-any char-alphabetic? phrase)
         (string-every char-upper-case?
		       (string-filter char-alphabetic? phrase)))))

(define question?
  (lambda (phrase)
    (char=? #\?
            (string-ref phrase
                        (- (string-length phrase) 1)))))

(define silent?
  (lambda (phrase)
    (or (string-null? phrase)
        (string-every char-whitespace? phrase))))

(define response-for
  (lambda (phrase)
    (cond ((silent? phrase) "Fine. Be that way!")
          ((shouting? phrase) "Whoa, chill out!")
          ((question? phrase) "Sure.")
          (else "Whatever."))))
