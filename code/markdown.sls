
(library (markdown)
  (export splice-exercism
          put-doc
          put-md)
  (import (chezscheme)
          (sxml)
          (outils))

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
  (define sxml-bindings
    `((section . ,(lambda (_ title . x)
                    `((h2 ,title) (nl) ,@x)))
      (subsection . ,(lambda (_ subtitle . x)
                       `((h3 ,subtitle) (nl) ,@x)))
      (paragraph . ,(lambda (_ . x)
                      `(,@x (nl))))
      (sentence . ,(lambda (_ . x)
                     `(,@x (nl))))
      (exercism-test-help
       *macro*
       .
       ,(lambda (_ exercism)
          `(section
            "Running and testing your solutions"
            (subsection
             "From the command line"
             (sentence "Simply type "
                       (inline-code "make chez")
                       " if you're using ChezScheme or "
                       (inline-code "make guile")
                       " if you're using GNU Guile.")
             (sentence "Sometimes the name for the scheme binary on your system will differ from the defaults.")
             (sentence "When this is the case, you'll need to tell make by running "
                       (inline-code "make chez chez=your-chez-binary")
                       " or "
                       (inline-code "make guile guile=your-guile-binary")
                       "."))
            (subsection
             "From a REPL"
             (enum
              (item "Enter " (inline-code "(load \"test.scm\")") " at the repl prompt.")
              (item "Develop your solution in "
                    (inline-code ,(format "~a.scm" exercism))
                    " reloading as you go.")
              (item "Run "
                    (inline-code "(test)")
                    " to check your solution.")))
            (subsection
             "Failed Test Cases"
             (sentence "If some of the test cases fail, you should see the failing input and the expected output.")
             (sentence "The failing input is presented as a list because the tests call your solution by "
                       (inline-code ,(with-output-to-string
                                      (lambda ()
                                        (write `(apply ,exercism input-list)))))
                       ".")
             (sentence "To learn more about "
                       (inline-code "apply")
                       " see "
                       (link "The Scheme Programming Language -- Chapter 5"
                             "https://www.scheme.com/tspl4/control.html#./control:h1"))))))
      (link . ,(case-lambda
                 ((_ description href)
                  `(*raw* "[" ,description "]" "(" ,href ")"))
                 ((_ description href title)
                  `(*raw* "[" ,description "]" "(" ,href "\"" ,title "\"" ")"))))
      (*default* . ,(lambda x x))
      (*text* . ,(lambda (_ . x) x))))

  (define (sxml->md tree)
    (cond
     ((nodeset? tree) (map sxml->md tree))
     ((pair? tree)
      (let* ((tag (name tree))
             (name (symbol->string tag))
             (content (content-raw tree)))
        (case tag
          ((*raw*) content)
          ((bold) `("__" ,@(sxml->md content) "__"))
          ((emphasis) `("_" ,@(sxml->md content) "_"))
          ((strike-through) `("~~" ,@(sxml->md content) "~~"))
          ((code) `("```" ,(car content) "\n" ,(cdr content) "\n" "```"))
          ((inline-code) `("`" ,content "`"))
          ((h1) `("\n" "# " ,@(sxml->md content) "\n"))
          ((h2) `("\n" "## " ,@(sxml->md content) "\n"))
          ((h3) `("\n" "### " ,@(sxml->md content) "\n"))
          ((h4) `("\n" "#### " ,@(sxml->md content) "\n"))
          ((h5) `("\n" "##### " ,@(sxml->md content) "\n"))
          ((h6) `("\n" "###### " ,@(sxml->md content) "\n"))
          ((item) `("* " ,@(sxml->md content) "\n"))
          ((enum) `(,@(sxml->md content)))
          ((nl) "\n")
          (else (error 'sxml->md "unexpected tag" tag)))))
     ((string? tree) (list (string->goodMD tree)))
     ((symbol? tree) (list (string->goodMD (symbol->string tree))))
     (else (error 'sxml->md "unexpected node" tree))))

  ;; a simple way to test the output. eventual goal is to generate the
  ;; markdown in docs/*
  (define (put-doc md)
    (let ((source (format "input/docs/~a.ss" md))
          (target (format "docs/~a.md" (symbol->string md))))
      (when (file-exists? target)
        (delete-file target))
      (with-output-to-file target
        (lambda ()
          (put-md (with-input-from-file source read-all))))))

  (define (put-md md)
    (send-reply
     (sxml->md
      (pre-post-order md sxml-bindings))))

  (define (md-hints md)
    `(section "Notes" ,@md))

  (define (splice-exercism problem . md)
    (if (null? md)
        `(exercism-test-help ,problem)
        `((section "Track Specific Notes" ,@md)
          (exercism-test-help ,problem))))
  
  )
