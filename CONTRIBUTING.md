# How to contribute to the Exercism Scheme track

## **Do you want to report a bug?**

- **Ensure the bug was not already reported** by searching the [forum][forum].

- If you are unable to find an open conversation addressing the problem, [open a new one][forum-new-topic].
  Be sure to include a **title and clear description**, as much relevant information as possible, and (when possible) a **code sample**.

## **Do you want to fix a bug?**

- **Ensure that the bug is reported (see above)**.
  Only start fixing the bug when there is agreement on whether (and how) it should be fixed.

- Fix the bug and [submit a Pull Request][pr-guide] to this repository.

- Ensure the PR description clearly describes the problem and solution.
  Include a link to the bug's corresponding forum conversation.

- Before submitting, please read the [Contributors Pull Request Guide][pr-guide] and [Pull Request Guide][pr-other-guide].

## **Do you intend to add a new feature or change an existing one?**

- **Ensure that the feature or change is discussed on the [forum][forum].**
  Only start adding the feature or change when there is agreement on whether (and how) it should be added or changed.

- Fork the exercism/scheme repo, add the feature or change in your clone, and [submit a Pull Request][pr-guide] to this repository.

- Ensure the PR description clearly describes the problem and solution.
  Include a link to the bug's corresponding forum conversation.

- Before submitting, please read the [Contributors Pull Request Guide][pr-guide] and [Pull Request Guide][pr-other-guide].

## **Do you want to add an exercise?**

- **Ensure that someone else isn't already adding it** 
  - start with the [Practice exercises to implement][exercise-list] issue.
  - also search the [forum][forum] and the repository's [issues][gh-issues] and [pull requests][gh-pulls].

- If nobody is yet adding the exercise, [open a conversation][forum] and indicate you'd like to add the exercise.

### Creating a new Practice Exercise

1. Run

    ```sh
    bin/add-practice-exercise ${slug_name}
    ```

    This creates the scaffolding for the new exercise:

    - The test, stub and example files are empty.
    - The canonical data from problem-specifications gets added into your local `canonical-data` directory.
    - A test generator template is created: `exercises/practice/${slug_name}/.meta/generator.tmpl`

1. Review the canonical data and decide if there are any tests cases to exclude.

   If there are, add `include = false` properties in the exercise's `.meta/tests.toml` file.

1. Considering the canonical data, decide if this exercise makes sense to use a test generator.

    - If no:
        - delete the stubbed .meta/generator.tmpl and create the test suite manually.
        - Use the file `canonical-data/${slug_name}.json` to create the tests.
        - Remember, this track uses TDD, so the first test uses `it` and all the rest use `pending`.

    - If yes:

        1. Edit `.meta/generator.tmpl` -- see below for more details.

        2. Run the generator script and review the new test suite.

            ```sh
            bin/generate-spec ${slug_name}
            ```

            Loop back to the previous step as needed.

1. Create the example solution: `.meta/example.moon`

1. Test it with

    ```sh
    bin/verify-exercises ${slug_name}
    ```

1. When you're satisfied with the solution, create the stub file `${slug_name}.moon`.
   Provide a stub for every function being tested.
   For classes, provide stubs for the constructor and each method.
   The stubbed function should emit an error.
   See what it looks like in other exercises.
   `complex-numbers` is a good one.

1. Revisit the exercise difficulty in config.json if the implementation was harder/easier than expected.

1. Run `bin/configlet lint` to ensure that the new exercise conforms to Exercism standards.

[forum]: https://forum.exercism.org/c/programming/scheme
[forum-new-topic]: https://forum.exercism.org/new-topic?category=scheme
[pr-guide]: https://exercism.org/docs/building/github/contributors-pull-request-guide
[pr-other-guide]: https://exercism.org/docs/community/being-a-good-community-member/pull-requests
[exercise-list]: https://github.com/exercism/moonscript/issues/102
[gh-issues]: https://github.com/exercism/moonscript/issues
[gh-pulls]: https://github.com/exercism/moonscript/pulls
[style]: ./STYLE.md
