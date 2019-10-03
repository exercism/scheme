# Transpose

Given an input text output it transposed.

Roughly explained, the transpose of a matrix:

```text
ABC
DEF
```

is given by:

```text
AD
BE
CF
```

Rows become columns and columns become rows. See <https://en.wikipedia.org/wiki/Transpose>.

If the input has rows of different lengths, this is to be solved as follows:

- Pad to the left with spaces.
- Don't pad to the right.

Therefore, transposing this matrix:

```text
ABC
DE
```

results in:

```text
AD
BE
C
```

And transposing:

```text
AB
DEF
```

results in:

```text
AD
BE
 F
```

In general, all characters from the input should also be present in the transposed output.
That means that if a column in the input text contains only spaces on its bottom-most row(s),
the corresponding output row should contain the spaces in its right-most column(s).

## Track Specific Notes

## Running and testing your solutions

### Overview


* Start a REPL either in your favorite editor or from
the command line\.
* Type `(load "transpose.scm")` at the prompt\.
* Test your code by calling `(test)` from the REPL\.
* Develop the solution in `transpose.scm` and reload as you go\.

### Testing options

You can see more or less information about
failing test cases an by passing additional arguments to the
procedure `test`\.
To see the failing input call `(test 'input)` and to see the input and output together call `(test 'input 'output)`\.

## Source

Reddit r/dailyprogrammer challenge #270 [Easy]. [https://www.reddit.com/r/dailyprogrammer/comments/4msu2x/challenge_270_easy_transpose_the_input_text](https://www.reddit.com/r/dailyprogrammer/comments/4msu2x/challenge_270_easy_transpose_the_input_text)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
