# Robot Name

Manage robot factory settings.

When robots come off the factory floor, they have no name.

The first time you boot them up, a random name is generated in the format
of two uppercase letters followed by three digits, such as RX837 or BC811.

Every once in a while we need to reset a robot to its factory settings,
which means that their name gets wiped. The next time you ask, it will
respond with a new random name.

The names must be random: they should not follow a predictable sequence.
Random names means a risk of collisions. Your solution must ensure that
every existing robot has a unique name.

# Running and testing your solutions

## Overview

Suppose you're solving __hello\-world__:

* Start a REPL, either in your favorite editor or from the
command line\.
* Type `(load "hello-world.scm")` at the prompt\.
* Test your code by calling `(test)` from the REPL\.

## Testing options

You can see more information about failing test cases by passing
arguments to the procedure `test`\. 
To see the failing input call `(test 'input)` and to see the output as well call `(test 'input 'output)`\.
## Source

A debugging session with Paul Blackwell at gSchool. [http://gschool.it](http://gschool.it)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
