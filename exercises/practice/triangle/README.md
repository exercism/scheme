# Triangle

Determine if a triangle is equilateral, isosceles, or scalene.

An _equilateral_ triangle has all three sides the same length.

An _isosceles_ triangle has at least two sides the same length. (It is
sometimes specified as having exactly two sides the same length, but for the
purposes of this exercise we'll say at least two.)

A _scalene_ triangle has all sides of different lengths.

## Note

For a shape to be a triangle at all, all sides have to be of length > 0, and
the sum of the lengths of any two sides must be greater than the length of the
third side. See [Triangle
Inequality](https://en.wikipedia.org/wiki/Triangle_inequality).

## Running and testing your solutions

### From the command line

NB: Unlike other exercises in this track, the tests for this exercise *only*
work with __GNU Guile__ (not Chez Scheme).

Simply execute,

```sh
$ guile test.scm
```
By default, only the first test is executed when you run the command. This is
intentional, as it allows you to focus on just making that one test pass. Once
it passes, you can enable the next test(s) by removing or commenting out
`(test-skip ...)`. When all tests have been enabled and your implementation
makes them all pass, you'll have solved the exercise!

### Failed Test Cases

If some of the test cases fail, you should be able to check the actual input
and the expected output from the log file (`triangle.log`).

## Source

The Ruby Koans triangle project, parts 1 & 2
[http://rubykoans.com](http://rubykoans.com)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have
completed the exercise.
