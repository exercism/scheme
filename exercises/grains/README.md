# Grains

Calculate the number of grains of wheat on a chessboard given that the number
on each square doubles.

There once was a wise servant who saved the life of a prince. The king
promised to pay whatever the servant could dream up. Knowing that the
king loved chess, the servant told the king he would like to have grains
of wheat. One grain on the first square of a chess board, with the number
of grains doubling on each successive square.

There are 64 squares on a chessboard (where square 1 has one grain, square 2 has two grains, and so on).

Write code that shows:
- how many grains were on a given square, and
- the total number of grains on the chessboard

## For bonus points

Did you get the tests passing and the code clean? If you want to, these
are some additional things you could try:

- Optimize for speed.
- Optimize for readability.

Then please share your thoughts in a comment on the submission. Did this
experiment make the code better? Worse? Did you learn anything from it?


## Track Specific Notes

The tests expect an error to be reported for out of
range inputs\.

## Running and testing your solutions


### From the command line

Simply type `make chez` if you're using ChezScheme or `make guile` if you're using GNU Guile\.
Sometimes the name for the scheme binary on your system will differ from the defaults\.
When this is the case, you'll need to tell make by running `make chez chez=your-chez-binary` or `make guile guile=your-guile-binary`\.

### From a REPL

* Enter `(load "test.scm")` at the repl prompt\.
* Develop your solution in `grains.scm` reloading as you go\.
* Run `(test)` to check your solution\.


## Source

JavaRanch Cattle Drive, exercise 6 [http://www.javaranch.com/grains.jsp](http://www.javaranch.com/grains.jsp)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
