# Pascal's Triangle

Compute Pascal's triangle up to a given number of rows.

In Pascal's Triangle each number is computed by adding the numbers to
the right and left of the current position in the previous row.

```text
    1
   1 1
  1 2 1
 1 3 3 1
1 4 6 4 1
# ... etc
```


## Running and testing your solutions


### From the command line

Simply type `make chez` if you're using ChezScheme or `make guile` if you're using GNU Guile\.

### From a REPL

* Enter `test.scm` at the repl prompt\.
* Develop your solution in the file `(load "pascals-triangle.scm")` reloading as you go\.
* Run `(test)` to check your solution\.


### Testing options

You can see more information about failing test cases by passing
arguments to the procedure `test`\.
 To see the failing input and output call `(test 'input 'output)`\.

## Source

Pascal's Triangle at Wolfram Math World [http://mathworld.wolfram.com/PascalsTriangle.html](http://mathworld.wolfram.com/PascalsTriangle.html)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
