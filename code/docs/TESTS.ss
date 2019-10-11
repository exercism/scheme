
(section
 "Running and testing your solutions"
 (subsection
  "From the command line"
  (sentence "Simply type "
            (inline-code "make chez")
            " if you're using ChezScheme or "
            (inline-code "make guile")
            " if you're using GNU Guile."))
 (subsection
  "From a REPL"
  (enum
   (item "Enter " (inline-code "test.scm") " at the repl prompt.")
   (item "Develop your solution in the file "
         (inline-code "problem.scm")
         " reloading as you go.")
   (item "Run "
         (inline-code "(test)")
         " to check your solution.")))
 (subsection
  "Testing options"
  (sentence "You can see more information about failing test cases by passing
arguments to the procedure "
            (inline-code "test") ".")
  (sentence 
   " To see the failing input and output call "
   (inline-code "(test 'input 'output)")
   ".")))


