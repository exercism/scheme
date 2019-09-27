(define content
  '((h1 "Recommended Resources")
    (nl) (h2 "Books") (nl)
    (enum
     (item
      (link "Structure and Interpretation of Computer Programs"
	    "http://mitpress.mit.edu/sicp/"))
     (item
      (link "The Scheme Programming Language"
	    "https://www.scheme.com/tspl4/")))
    (nl) (h2 "Manuals") (nl)
    (enum
     (item
      (link ChezScheme
	    "http://cisco.github.io/ChezScheme/csug9.5/csug.html"))
     (item
      (link "GNU Guile"
	    "https://www.gnu.org/software/guile/manual/")))
    (nl) (h2 "Miscellaneous") (nl)
    (enum
     (item
      (link "Oleg Kiselyov's website"
	    "http://okmij.org/ftp/Scheme/"))
     (item
      (link "'(schemers . org)"
	    "https://schemers.org/"))
     (item
      (link "Style Guide"
	    "https://mumble.net/~campbell/scheme/style.txt"))
     (item
      (link "The Revised ^6 Report"
	    "http://www.r6rs.org/"))
     (item
      (link "Coursera CS 341"
	    "https://www.coursera.org/learn/programming-languages-part-b")))
    (nl) (h2 "Emacs modes") (nl)
    (enum
     (item
      (link "Geiser"
	    "http://www.nongnu.org/geiser/"))
     (item
      (link "Par Edit"
	    "https://www.emacswiki.org/emacs/ParEdit"))
     (item
      (link "Rainbow Delimiters"
	    "https://www.emacswiki.org/emacs/RainbowDelimiters")))))

