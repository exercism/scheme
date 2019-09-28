(unless (assoc "code" (library-directories))
  (library-directories (cons "code" (library-directories))))

(import (json)
	(sxml))

(define source-files
  '("code/outils.ss"
    "code/config.ss"
    "code/test.ss"
    "code/md.ss"
    "code/track.ss"))

(for-each load source-files)
