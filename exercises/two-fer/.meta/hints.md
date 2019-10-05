
## Track Specific Notes

One way to get optional arguments in scheme is by specifying the arguments as a list\.
Two ways to do that are: `(define (two-fer . args) ...)` or `(define two-fer (lambda args ...))`\.

## Running and testing your solutions


### From the command line

Simply type `make chez` if you're using ChezScheme or `make guile` if you're using GNU Guile\.

### From a REPL

* Enter `test.scm` at the repl prompt\.
* Develop your solution in `two-fer.scm` reloading as you go\.
* Run `(test)` to check your solution\.


### Testing options

You can see more information about failing test cases by passing
arguments to the procedure `test`\.
 To see the failing input and output call `(test 'input 'output)`\.
