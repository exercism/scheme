# Pangram

Determine if a sentence is a pangram. A pangram (Greek: παν γράμμα, pan gramma,
"every letter") is a sentence using every letter of the alphabet at least once.
The best known English pangram is:
> The quick brown fox jumps over the lazy dog.

The alphabet used consists of ASCII letters `a` to `z`, inclusive, and is case
insensitive. Input will not contain non-ASCII symbols.


## Track Specific Notes

Consider inputs case insensitive
and allow more than one of each required char\.

## Running and testing your solutions


### From the command line

Simply type `make chez` if you're using ChezScheme or `make guile` if you're using GNU Guile\.

### From a REPL

* Enter `test.scm` at the repl prompt\.
* Develop your solution in `pangram.scm` reloading as you go\.
* Run `(test)` to check your solution\.


### Testing options

You can see more information about failing test cases by passing
arguments to the procedure `test`\.
 To see the failing input and output call `(test 'input 'output)`\.

## Source

Wikipedia [https://en.wikipedia.org/wiki/Pangram](https://en.wikipedia.org/wiki/Pangram)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
