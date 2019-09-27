(unless (assoc "code" (library-directories))
  (library-directories (cons "code" (library-directories))))

(import (json)
	(sxml))

(define (load-problem problem)
  (load (format "code/exercises/~a/~a.ss" problem problem)))

(define source-files
  '("code/outils.ss"
    "code/config.ss"
    "code/test.ss"
    "code/track.ss"))



(for-each load source-files)






