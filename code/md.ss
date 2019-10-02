
;;; Markdown

(define string->goodMD
  (make-char-quotator '((#\_ . "\\_")
			(#\- . "\\-")
			(#\` . "\\`")
			(#\~ . "\\~")
			(#\# . "\\#")
			(#\* . "\\*")
			(#\+ . "\\+")
			(#\. . "\\.")
			(#\! . "\\!")
			(#\{ . "\\{")
			(#\} . "\\}")
			(#\[ . "\\[")
			(#\] . "\\]")
			(#\( . "\\(")
			(#\) . "\\)"))))

;; transform sxml tree into tree of strings. the tree of strings can
;; be traversed outputting each node with `send-reply`.
(define (sxml->md tree)
  (cond
   ((nodeset? tree) (map sxml->md tree))
   ((pair? tree)
    (let* ((tag (name tree))
	   (name (symbol->string tag))
	   (content (content-raw tree)))
      (case tag
	((bold) `("__" ,@(sxml->md content) "__"))
	((emphasis) `("_" ,@(sxml->md content) "_"))
	((strike-through) `("~~" ,@(sxml->md content) "~~"))
	((code) `("```" ,(car content) "\n" ,(cdr content) "\n" "```"))
	((inline-code) `("`" ,content "`"))
	((h1) `("# " ,@(sxml->md content) "\n"))
	((h2) `("## " ,@(sxml->md content) "\n"))
	((h3) `("### " ,@(sxml->md content) "\n"))
	((h4) `("#### " ,@(sxml->md content) "\n"))
	((h5) `("##### " ,@(sxml->md content) "\n"))
	((h6) `("###### " ,@(sxml->md content) "\n"))
	((item) `("* " ,@(sxml->md content) "\n"))
	((enum) `("\n" ,@(sxml->md content) "\n"))
	((link)
	 (unless (and (list? content) (= 2 (length content)))
	   (error 'sxml->md "incorrect link. provide description and url"
		  content))
	 `("[" ,(car content) "]" "(" ,(cadr content) ")"))
	((link-with-title)
	 (unless (and (list? content) (= 3 (length content)))
	   (error 'sxml->md "incorrect link. provide description and url and title"
		  content))
	 `("[" ,(car content) "](" ,(cadr content) " \"" ,(caddr content) "\")"))
	((sentence)
	 `(,@(sxml->md content) "\n"))
	((nl)
	 "\n")
	(else (error 'sxml->md "unexpected tag" tag)))))
   ((string? tree) (list (string->goodMD tree)))
   ((symbol? tree) (list (string->goodMD (symbol->string tree))))
   (else (error 'sxml->md "unexpected node" tree))))

;; a simple way to test the output. eventual goal is to generate the
;; markdown in docs/*
(define (put-md md)
  (let ((source (format "code/docs/~a.ss" md))
	(target (format "docs/~a.md" (string-upcase (symbol->string md)))))
    (load source)
    (when (file-exists? target)
      (delete-file target))
    (with-output-to-file target
      (lambda ()
	(send-reply (sxml->md content))))))

(define (md-hints md)
  `((h1 "Notes") (nl)
    ,@md))


