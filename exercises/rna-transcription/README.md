# RNA Transcription

Given a DNA strand, return its RNA complement (per RNA transcription).

Both DNA and RNA strands are a sequence of nucleotides.

The four nucleotides found in DNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and thymine (**T**).

The four nucleotides found in RNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and uracil (**U**).

Given a DNA strand, its transcribed RNA strand is formed by replacing
each nucleotide with its complement:

* `G` -> `C`
* `C` -> `G`
* `T` -> `A`
* `A` -> `U`


## Running and testing your solutions


### From the command line

Simply type `make chez` if you're using ChezScheme or `make guile` if you're using GNU Guile\.
Sometimes the name for the scheme binary on your system will differ from the defaults\.
When this is the case, you'll need to tell make by running `make chez chez=your-chez-binary` or `make guile guile=your-guile-binary`\.

### From a REPL

* Enter `(load "test.scm")` at the repl prompt\.
* Develop your solution in `rna-transcription.scm` reloading as you go\.
* Run `(test)` to check your solution\.

### Failed Test Cases

If some of the test cases fail, you should see the failing input and the expected output\.
The failing input is presented as a list because the tests call your solution by `(apply rna-transcription input-list)`\.
To learn more about `apply` see [The Scheme Programming Language -- Chapter 5](https://www.scheme.com/tspl4/control.html#./control:h1)

## Source

Hyperphysics [http://hyperphysics.phy-astr.gsu.edu/hbase/Organic/transcription.html](http://hyperphysics.phy-astr.gsu.edu/hbase/Organic/transcription.html)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
