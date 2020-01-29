(import (rnrs))

(define (response-for message)
  (let ((not-whitespace?
         (lambda (c) (not (char-whitespace? c)))))
    (bob-reply (list->string
		(filter not-whitespace?
			(string->list message))))))

;; Now we can really easily write new responder functions
(define (bob-reply message)
  (case (classify message)
   ((Silence)   "Fine. Be that way!")
   ((Statement) "Whatever.")
   ((Yelling)   "Whoa, chill out!")
   ((Question)  "Sure.")
   ((YellQuest) "Calm down, I know what I'm doing!")))

(define classify
  (let ((yelling?
         (lambda (message)
           (and (ormap char-upper-case? (string->list message))
                (not (ormap char-lower-case? (string->list message))))))
        (question?
         (lambda (message)
           (unless (string=? "" message)
             (char=? #\? (string-last message))))))
    (lambda (message)
      ;; confusing shadowing - what should they be?
      ;; the point is to cache them
      (define question (question? message))
      (define yelling  (yelling?  message))
      ;; transform results to enum
      (cond ((string=? "" message)  'Silence)
            ((and yelling question) 'YellQuest)
            (yelling                'Yelling)
            (question               'Question)
            (else                   'Statement)))))

;; Unsafe Last
(define (string-last string)
  (string-ref string (1- (string-length string))))

;; Poor Man's ormap
(define (ormap pred xs)
  (if (null? xs) #f (or (pred (car xs)) (ormap pred (cdr xs)))))
