
(defun exorcize-tabs ()
  (interactive)
  (message "Converting tabs to spaces in buffer: `%s'" (buffer-name))
  (untabify (point-min) (point-max)))
