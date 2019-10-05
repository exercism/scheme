# Knapsack

In this exercise, let's try to solve a classic problem.

Bob is a thief. After months of careful planning, he finally manages to
crack the security systems of a high-class apartment.

In front of him are many items, each with a value (v) and weight (w). Bob,
of course, wants to maximize the total value he can get; he would gladly
take all of the items if he could. However, to his horror, he realizes that
the knapsack he carries with him can only hold so much weight (W).

Given a knapsack with a specific carrying capacity (W), help Bob determine
the maximum value he can get from the items in the house. Note that Bob can
take only one of each item.

All values given will be strictly positive. Items will be represented as a
list of pairs, `wi` and `vi`, where the first element `wi` is the weight of
the *i*th item and `vi` is the value for that item.

For example:

Items: [
  { "weight": 5, "value": 10 },
  { "weight": 4, "value": 40 },
  { "weight": 6, "value": 30 },
  { "weight": 4, "value": 50 }
]

Knapsack Limit: 10

For the above, the first item has weight 5 and value 10, the second item has
weight 4 and value 40, and so on.

In this example, Bob should take the second and fourth item to maximize his
value, which, in this case, is 90. He cannot get more than 90 as his
knapsack has a weight limit of 10.

## Track Specific Notes

In the scheme version the aruguments are the `capacity` of the knapsack and a list of the `weights` and a list of the `values`\.
It won't be necessary to validate the input \-\- the
test inputs have valid values and same length lists\.
## Running and testing your solutions

### Overview


* Start a REPL either in your favorite editor or from
the command line\.
* Type `(load "knapsack.scm")` at the prompt\.
* Test your code by calling `(test)` from the REPL\.
* Develop the solution in `knapsack.scm` and reload as you go\.

### Testing options

You can see more or less information about
failing test cases an by passing additional arguments to the
procedure `test`\.
To see the failing input call `(test 'input)` and to see the input and output together call `(test 'input 'output)`\.

## Source

Wikipedia [https://en.wikipedia.org/wiki/Knapsack_problem](https://en.wikipedia.org/wiki/Knapsack_problem)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
