
(define content
  `((h1 "Running and testing your solutions") (nl)
    (h2 "Overview") (nl)
    "Suppose you're solving "
    (bold "hello-world")
    ":\n"
    (enum
     (item "Start a REPL, either in your favorite editor or from the
command line.")
     (item "Type "
	   (inline-code "(load \"hello-world.scm\")")
	   " at the prompt.")
     (item "Test your code by calling "
	   (inline-code "(test)")
	   " from the REPL."))
    (h2 "Testing options") (nl)
    "You can see more information about failing test cases by passing
arguments to the procedure "
    (inline-code "test") ". " (nl)
    "To see the failing input call "
    (inline-code "(test 'input)")
    " and to see the output as well call "
    (inline-code "(test 'input 'output)")
    "."
    
    ))

