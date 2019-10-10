(unless (assoc "code" (library-directories))
  (library-directories (cons "code" (library-directories))))

(import (json)
        (outils)
        (lint)
        (markdown))

(define source-files
  '("code/test.ss"
    "code/track.ss"))

(for-each load source-files)
