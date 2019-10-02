# Two Fer

`Two-fer` or `2-fer` is short for two for one. One for you and one for me.

Given a name, return a string with the message:

```text
One for X, one for me.
```

Where X is the given name.

However, if the name is missing, return the string:

```text
One for you, one for me.
```

Here are some examples:

|Name    |String to return 
|:-------|:------------------
|Alice   |One for Alice, one for me. 
|Bob     |One for Bob, one for me.
|        |One for you, one for me.
|Zaphod  |One for Zaphod, one for me.

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

[https://github.com/exercism/problem-specifications/issues/757](https://github.com/exercism/problem-specifications/issues/757)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
