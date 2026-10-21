(import (rnrs))

(define (compute left operation right)
  (case operation
    ((plus) (+ left right))
    ((minus) (- left right))
    ((multiplied-by) (* left right))
    ((divided-by) (quotient left right))
    (else #f)))

(define (calculate left operation tokens)
  (if (null? tokens)
      #f
      (let ((right (string->number (car tokens))))
        (if right
            (let ((left (compute left operation right))
                  (tokens (cdr tokens)))
              (cond
                ((null? tokens)
                 left)
                ((null? (cdr tokens))
                 #f)
                ((string=? "plus" (car tokens))
                 (calculate left 'plus (cdr tokens)))
                ((string=? "minus" (car tokens))
                 (calculate left 'minus (cdr tokens)))
                ((and (string=? "multiplied" (car tokens)) (string=? "by" (cadr tokens)))
                 (calculate left 'multiplied-by (cddr tokens)))
                ((and (string=? "divided" (car tokens)) (string=? "by" (cadr tokens)))
                 (calculate left 'divided-by (cddr tokens)))
                (else
                 #f)))
            #f))))

(define (answer question)
  (let ((question-length (string-length question)))
    (or (and (< 8 question-length)
             (string=? "What is " (substring question 0 8))
             (string=? "?" (substring question (- question-length 1) question-length))
             (calculate 0 'plus (string-split (substring question 8 (- question-length 1)) char-whitespace?)))
        (error 'answer "parse error" question))))
