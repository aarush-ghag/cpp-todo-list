#!/bin/sh

set -eu

testBinary="/tmp/todo-list-test-$$"
trap 'rm -f "$testBinary"' EXIT HUP INT TERM

g++ -std=c++17 -Wall -Wextra main.cpp -o "$testBinary"

output=$(printf '2\n1\nBuy milk\n1\nRead book\n1\n\n2\n9\n3\n' | "$testBinary")

require_output() {
    if ! printf '%s\n' "$output" | grep -F -q "$1"; then
        printf 'Expected output to contain: %s\n' "$1" >&2
        exit 1
    fi
}

require_output '1. Add task'
require_output '2. View tasks'
require_output '3. Quit'
require_output 'No tasks yet.'
require_output 'Task added.'
require_output 'Task cannot be empty.'
require_output '1. Buy milk'
require_output '2. Read book'
require_output 'Invalid choice.'

task_added_count=$(printf '%s\n' "$output" | grep -F -c 'Task added.' || true)
if [ "$task_added_count" -ne 2 ]; then
    printf 'Expected exactly two successful task additions.\n' >&2
    exit 1
fi

if ! printf '' | "$testBinary" >/dev/null; then
    printf 'Expected the program to exit cleanly at end-of-file.\n' >&2
    exit 1
fi
