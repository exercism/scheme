## Track Specific Notes

One way to get optional arguments in scheme is by specifying the arguments as a list\.
Two ways to do that are: `(define (two-fer . args) ...)` or `(define two-fer (lambda args ...))`\.
## Running and testing your solutions

### Overview


* Start a REPL either in your favorite editor or from
the command line\.
* Type `(load "two-fer.scm")` at the prompt\.
* Test your code by calling `(test)` from the REPL\.
* Develop the solution in `two-fer.scm` and reload as you go\.

### Testing options

You can see more or less information about
failing test cases an by passing additional arguments to the
procedure `test`\.
To see the failing input call `(test 'input)` and to see the input and output together call `(test 'input 'output)`\.
