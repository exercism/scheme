(define-module (anagram)
  #:export (anagrams-for))

;; Credit where credit is due: example borrows heavily
;; from xlisp/anagram

(define anagram-equal
  (lambda (a b)
    (let ((sorted-string
           (lambda (s)
             (apply string (sort (string->list s) char-ci<?)))))
      (and
       (string-ci=? (sorted-string a)
                 (sorted-string b))
       (not (string-ci=? a b))))))

(define anagrams-for
  (lambda (subject candidates)
    (filter (lambda (w) (anagram-equal w subject)) candidates)))
