
(defun exorcize-tabs ()
  (interactive)
  (message "Converting tabs to spaces in buffer: `%s'" (buffer-name))
  (untabify (point-min) (point-max)))

(defun r6rs-directive ()
  (interactive)
  (goto-line 0)
  (princ "#!r6rs\n\n" (current-buffer)))
