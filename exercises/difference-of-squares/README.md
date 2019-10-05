# Difference Of Squares

Find the difference between the square of the sum and the sum of the squares of the first N natural numbers.

The square of the sum of the first ten natural numbers is
(1 + 2 + ... + 10)² = 55² = 3025.

The sum of the squares of the first ten natural numbers is
1² + 2² + ... + 10² = 385.

Hence the difference between the square of the sum of the first
ten natural numbers and the sum of the squares of the first ten
natural numbers is 3025 - 385 = 2640.

You are not expected to discover an efficient solution to this yourself from
first principles; research is allowed, indeed, encouraged. Finding the best
algorithm for the problem is a key skill in software engineering.


## Running and testing your solutions


### From the command line

Simply type `make chez` if you're using ChezScheme or `make guile` if you're using GNU Guile\.

### From a REPL

* Enter `test.scm` at the repl prompt\.
* Develop your solution in the file `(load "difference-of-squares.scm")` reloading as you go\.
* Run `(test)` to check your solution\.


### Testing options

You can see more information about failing test cases by passing
arguments to the procedure `test`\.
 To see the failing input and output call `(test 'input 'output)`\.

## Source

Problem 6 at Project Euler [http://projecteuler.net/problem=6](http://projecteuler.net/problem=6)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
