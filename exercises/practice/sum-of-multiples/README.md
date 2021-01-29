# Sum of Multiples

Given a list of integers and a limit, find the sum of all the unique multiples
of those integers up to but not including the limit.

If we list all the natural numbers below 20 that are multiples of 3 or 5,
we get 3, 5, 6, 9, 10, 12, 15, and 18.

The sum of these multiples is 78.

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
and the expected output from the log file (`sum-of-multiples.log`).

## Source

A variation on Problem 1 at Project Euler
[http://projecteuler.net/problem=1](http://projecteuler.net/problem=1)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have
completed the exercise.
