#!/bin/bash

failed=0
ROOT="$(pwd)"
for exercise_directory in $(find ./exercises/* -type d); do
    tmpdir=$(mktemp -d)
    test_file="$(find "$exercise_directory" -type f -name '*-test.scm')"
    solution_file="$exercise_directory/example.scm"
    cp "$test_file" "$tmpdir"
    cp "$solution_file" "$tmpdir/$(basename "${test_file//-test}")"
    cd "$tmpdir" && guile "$(basename $test_file)"
    ret="$?"
    cd "$ROOT"
    rm -rf "$tmpdir"
    if [ -n "$ret" ]; then
        failed="$(( failed + 1 ))"
    fi
done

echo "$failed failed exercises."
exit "$failed"
