#!/usr/bin/env python3

"""

See docs/TEST.md for usage of this script

Use this script to create an initial <exercise>/test.scm file
which can be used as a skeleton for your test. Typically, you will
have to replace 'response' in the generated file with the right
function call.

Prerequisites
- Python 3.x (it may work with Python 2.x, but that is untested)
- Up-to-date local version of the https://github.com/exercism/problem-specifications.git repo

Workflow for creating a new test
- pull latest changes from exercism/problem-specifications
- run this script for the example you want to create
- copy test-util.ss and Makefile for exercise directory
- implement working exercise
- fix potential problematic tests (see eg. exercise/bob "Test 20" and "Test 24")
- open a pull request with your changes

For bob example:

$ python3 bin/update-new-exercise-files.py --exercise_path exercises/practice/bob
$ cp config/CMakeLists.txt exercises/practice/bob/.
$ cd exercises/practice/bob
"""

import argparse
import json
import os
import pathlib
import textwrap


class Exercise:
    """Exercise holds exercise data."""

    def __init__(self, exercise_path):
        exercise_path = pathlib.Path(exercise_path)
        if not exercise_path.exists():
            raise ValueError(f"{exercise_path} does not exist")
        if not exercise_path.is_dir():
            raise ValueError(f"{exercise_path} is not a directory")

        slug = exercise_path.name
        self.config = json.loads((exercise_path / ".meta" / "config.json").read_text())

        self.slug = slug
        self.name = slug.replace("-", "_")
        self.path = exercise_path

    def config_file(self, filetype):
        if len(self.config["files"][filetype]) != 1:
            raise ValueError(f"Expected exactly one {filetype} file; got {self.config["files"][filetype]!r}")
        return self.path / self.config["files"][filetype][0]

    def write_file(self, filepath, content):
        if filepath.exists():
            print(f"{filepath} already exists; will not replace.")
        else:
            filepath.write_text(content.strip() + "\n")
            print(f"Wrote to {filepath}")

    def write_stub_file(self, content):
        self.write_file(self.config_file("solution"), content)

    def write_example_file(self, content):
        self.write_file(self.config_file("example"), content)

    def write_test_template(self, content):
        filepath = self.path / ".meta/template.j2"
        self.write_file(filepath, content)


def stub_implementation(exercise_name: str) -> str:
    return textwrap.dedent("""\
        module {exercise_name}
          implicit none
        contains

          logical function dummy()
            dummy=.true.
          end function

        end module
    """)


def template_stub() -> str:
    return textwrap.dedent("""\
        {{ header }}
    
        (load "test-util.ss")
        
        (define test-cases
          `(
        {%- for case in cases %}
        {%- if not case["expect_error"] %}
            (test-success "{{ loop.index }}. {{ case["description"] }}" = {{ case["property"] }} '({{ case["input"]["..."] }}) {{ case["expected"] }})
        {%- else %}
            (test-error "{{ case["description"] }}" {{ case["property"] }} '({{ case["input"]["..."] }}))
        {%- endif %}
        {%- endfor %}
            ))
        
        (run-with-cli "{{ name }}.scm" (list test-cases))
    """)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create exercise")
    parser.add_argument("-e", "--exercise_path", help="The path of the exercise")

    args = parser.parse_args()
    exercise = Exercise(args.exercise_path)

    exercise.write_stub_file(stub_implementation(exercise.name))
    exercise.write_example_file(stub_implementation(exercise.name))
    exercise.write_test_template(template_stub())

    print(f"Use './bin/generate_tests {exercise.slug}' to generate the test file from the Jinja template ({exercise.path / ".meta/template.j2"}).")
