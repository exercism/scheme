# Hello World

The classical introductory exercise. Just say "Hello, World!".

["Hello, World!"](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program) is
the traditional first program for beginning programming in a new language
or environment.

The objectives are simple:

- Write a function that returns the string "Hello, World!".
- Run the test suite and make sure that it succeeds.
- Submit your solution and check it at the website.

If everything goes well, you will be ready to fetch your first real exercise.

# Notes

Your solution may be a procedure that
returns the desired string or a variable whose value is that
string\.


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

This is an exercise to introduce users to using Exercism [http://en.wikipedia.org/wiki/%22Hello,_world!%22_program](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
