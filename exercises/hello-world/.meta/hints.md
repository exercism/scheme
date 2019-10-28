
## Track Specific Notes

Your solution may be a procedure that
returns the desired string or a variable whose value is that
string\.

## Running and testing your solutions


### From the command line

Simply type `make chez` if you're using ChezScheme or `make guile` if you're using GNU Guile\.
Sometimes the name for the scheme binary on your system will differ from the defaults\.
When this is the case, you'll need to tell make by running `make chez chez=your-chez-binary` or `make guile guile=your-guile-binary`\.

### From a REPL

* Enter `(load "test.scm")` at the repl prompt\.
* Develop your solution in `hello-world.scm` reloading as you go\.
* Run `(test)` to check your solution\.

