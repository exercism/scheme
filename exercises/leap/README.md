# Leap

Given a year, report if it is a leap year.

The tricky thing here is that a leap year in the Gregorian calendar occurs:

```text
on every year that is evenly divisible by 4
  except every year that is evenly divisible by 100
    unless the year is also evenly divisible by 400
```

For example, 1997 is not a leap year, but 1996 is.  1900 is not a leap
year, but 2000 is.

## Notes

Though our exercise adopts some very simple rules, there is more to
learn!

For a delightful, four minute explanation of the whole leap year
phenomenon, go watch [this youtube video][video].

[video]: http://www.youtube.com/watch?v=xX96xng7sAE

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

JavaRanch Cattle Drive, exercise 3 [http://www.javaranch.com/leap.jsp](http://www.javaranch.com/leap.jsp)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
