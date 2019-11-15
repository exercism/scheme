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
Sometimes the name for the scheme binary on your system will differ from the defaults\.
When this is the case, you'll need to tell make by running `make chez chez=your-chez-binary` or `make guile guile=your-guile-binary`\.

### From a REPL

* Enter `(load "test.scm")` at the repl prompt\.
* Develop your solution in `difference-of-squares.scm` reloading as you go\.
* Run `(test)` to check your solution\.

### Failed Test Cases

If some of the test cases fail, you should see the failing input and the expected output\.
The failing input is presented as a list because the tests call your solution by `(apply difference-of-squares input-list)`\.
To learn more about `apply` see [The Scheme Programming Language -- Chapter 5](https://www.scheme.com/tspl4/control.html#./control:h1)

## Source

Problem 6 at Project Euler [http://projecteuler.net/problem=6](http://projecteuler.net/problem=6)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
