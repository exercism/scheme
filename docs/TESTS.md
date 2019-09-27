# Running and testing your solutions

## Overview

Suppose you're solving __hello-world__:

* Start a REPL, either in your favorite editor or from the
command line.
* Type `(load "hello-world.scm")` at the prompt.
* Test your code by calling `(test)` from the REPL.

## Testing options

You can see more information about failing test cases by passing
arguments to the procedure `test`. 
To see the failing input call `(test 'input)` and to see the output as well call `(test 'input 'output)`.