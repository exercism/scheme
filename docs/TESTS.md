### Running tests

Let's start by `hello-world`. To solve this exercism, the first step
is to fire up a scheme repl from the command line or from your
favorite text editor. From the command line, type:

```bash
scheme
```

Once the repl is up and running:

```scheme
(load "hello-world.scm")
(load "test.scm")
```

Will load the stub solution and the accompanying test suite. To check
your solution type

```scheme
(test)
```

which should output the following message:

```

Passed 0/1 tests.

The following test cases failed:

* Say Hi!

failure
```

Interactively develop your solution by editing "hello-world.scm" and
reload the file by typing

```scheme
(load "hello-world.scm")
```

Once your solution is correct, running

```scheme
(test)
```

will output

```

Well done!

success
```

