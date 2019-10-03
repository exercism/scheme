# Prime Factors

Compute the prime factors of a given natural number.

A prime number is only evenly divisible by itself and 1.

Note that 1 is not a prime number.

## Example

What are the prime factors of 60?

- Our first divisor is 2. 2 goes into 60, leaving 30.
- 2 goes into 30, leaving 15.
  - 2 doesn't go cleanly into 15. So let's move on to our next divisor, 3.
- 3 goes cleanly into 15, leaving 5.
  - 3 does not go cleanly into 5. The next possible factor is 4.
  - 4 does not go cleanly into 5. The next possible factor is 5.
- 5 does go cleanly into 5.
- We're left only with 1, so now, we're done.

Our successful divisors in that computation represent the list of prime
factors of 60: 2, 2, 3, and 5.

You can check this yourself:

- 2 * 2 * 3 * 5
- = 4 * 15
- = 60
- Success!

# Running and testing your solutions

## Overview

Suppose you're solving __halting\-problem__:

* Start a REPL, either in your favorite editor or from the
command line\.
* Type `(load "halting-problem.scm")` at the prompt\.
* Test your code by calling `(test)` from the REPL\. At first this should result in failed tests\.
* Develop your solution in "halting\-problem\.scm" and
reload the file to run the tests again\.

## Testing options

You can see more information about failing test cases by passing
arguments to the procedure `test`\.
To see the failing input call `(test 'input)` and to see the input and output together call `(test 'input 'output)`\.

## Source

The Prime Factors Kata by Uncle Bob [http://butunclebob.com/ArticleS.UncleBob.ThePrimeFactorsKata](http://butunclebob.com/ArticleS.UncleBob.ThePrimeFactorsKata)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
