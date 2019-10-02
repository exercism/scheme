
(define content
  `((h1 "Running and testing your solutions") (nl)
    (h2 "Overview") (nl)
    "Suppose you're solving "
    (bold "halting-problem")
    ":\n"
    (enum
     (item "Start a REPL, either in your favorite editor or from the
command line.")
     (item "Type "
	   (inline-code "(load \"halting-problem.scm\")")
	   " at the prompt.")
     (item "Test your code by calling "
	   (inline-code "(test)")
	   " from the REPL. At first this should result in failed tests.")
     (item "Develop your solution in \"halting-problem.scm\" and
reload the file to run the tests again."))
    (h2 "Testing options") (nl)
    "You can see more information about failing test cases by passing
arguments to the procedure "
    (inline-code "test") ". " (nl)
    "To see the failing input call "
    (inline-code "(test 'input)")
    " and to see the input and output together call "
    (inline-code "(test 'input 'output)")
    "."))


