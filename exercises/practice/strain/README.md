# Strain

Implement the `keep` and `discard` operation on collections. Given a collection
and a predicate on the collection's elements, `keep` returns a new collection
containing those elements where the predicate is true, while `discard` returns
a new collection containing those elements where the predicate is false.

For example, given the collection of numbers:

- 1, 2, 3, 4, 5

And the predicate:

- is the number even?

Then your keep operation should produce:

- 2, 4

While your discard operation should produce:

- 1, 3, 5

Note that the union of keep and discard is all the elements.

The functions may be called `keep` and `discard`, or they may need different
names in order to not clash with existing functions or concepts in your
language.

## Restrictions

Keep your hands off that filter/reject/whatchamacallit functionality
provided by your standard library!  Solve this one yourself using other
basic tools instead.

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
and the expected output from the log file (`strain.log`).

## Source

Conversation with James Edward Gray II [https://twitter.com/jeg2](https://twitter.com/jeg2)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
