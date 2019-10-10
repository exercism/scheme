(unless (assoc "code" (library-directories))
  (library-directories (cons "code" (library-directories))))

(import (json)
        (outils)
        (lint)
        (markdown))

(load "code/track.ss")

