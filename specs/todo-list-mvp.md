# Spec: Console To-Do List MVP

## Objective

Build a small, beginner-friendly C++ console program for a single user. During one program run, the user can add a task, view all added tasks, and quit.

The MVP succeeds when a user can complete this flow without restarting or crashing:

1. Add one or more non-empty tasks.
2. View the tasks in the order they were added.
3. Quit cleanly.

Tasks are stored in memory only and are lost when the program exits.

## Tech Stack

- Language: C++17
- Standard library only: `std::vector`, `std::string`, `std::getline`, and console I/O
- No third-party dependencies, classes, files, databases, or network access

## Commands

Build:

```bash
g++ -std=c++17 -Wall -Wextra main.cpp -o app
```

Run:

```bash
./app
```

Existing convenience runner:

```bash
./test_runner.sh
```

## Project Structure

```text
main.cpp               -> console application source
test_runner.sh         -> compiles and launches the application
specs/todo-list-mvp.md -> MVP requirements and implementation plan
tests/                 -> optional scripted tests
```

## User Interaction Contract

The program displays this menu repeatedly until the user quits or input ends:

```text
1. Add task
2. View tasks
3. Quit
```

Menu choices and task text are read with `std::getline`. Exact menu choices are `"1"`, `"2"`, and `"3"`; all other input displays `Invalid choice.` and returns to the menu. If input reaches end-of-file, the program exits cleanly.

Required messages and output format:

```text
Task added.
Task cannot be empty.
No tasks yet.
1. Buy milk
```

- An empty task is exactly an empty line. Whitespace-only task text is allowed in this MVP to avoid introducing trimming logic.
- Tasks are listed in insertion order and numbered from one.

## Code Style

- Keep all MVP logic in `main.cpp`.
- Use descriptive, lower-camel-case names such as `tasks` and `menuChoice`.
- Prefer small, direct control flow over abstractions not needed by the assignment.
- Read all interactive input as full lines to avoid mixing formatted extraction with `std::getline`.

```cpp
std::string menuChoice;
std::getline(std::cin, menuChoice);

if (menuChoice == "1") {
    // Add a task.
}
```

## Testing Strategy

Manual verification is required for this MVP:

1. View tasks before adding one and confirm `No tasks yet.` appears.
2. Add at least two tasks and confirm `Task added.` appears each time.
3. View tasks and confirm they are ordered and numbered from one.
4. Submit an empty task and confirm it is rejected.
5. Enter an invalid menu choice and confirm the menu continues.
6. Choose Quit and confirm the program exits.

Optional: add a POSIX-shell scripted smoke test under `tests/` after the core MVP works. It must use the output contract above and must not require an interactive terminal.

## Boundaries

- Always: use C++17 standard-library facilities, preserve insertion order, validate empty task lines, and build with warnings enabled.
- Ask first: add persistence, task editing/deletion/completion, third-party libraries, classes, new build tools, or CI configuration.
- Never: add authentication, networking, databases, GUI code, or features beyond add/view/quit to this MVP.

## Implementation Plan

1. Create an in-memory `std::vector<std::string>` and a line-based menu loop.
2. Implement Add Task, including empty-line feedback.
3. Implement View Tasks, including the empty-list state and one-based numbering.
4. Implement Quit and graceful end-of-file exit.
5. Optionally add a scripted smoke test once the required functionality is complete.

All four core steps are sequential because they share the same menu loop and task collection.

## Success Criteria

- [ ] The application builds with `g++ -std=c++17 -Wall -Wextra main.cpp -o app`.
- [ ] The user can add a non-empty task during a single run.
- [ ] The user can view all added tasks in insertion order with one-based numbering.
- [ ] An empty task line is rejected without adding a task.
- [ ] Invalid menu input does not terminate or trap the application.
- [ ] Choosing `3` or reaching end-of-file exits cleanly.
- [ ] No features outside add, view, and quit are implemented.

## Open Questions

None for the MVP. Whitespace-only task text is intentionally accepted; changing that behavior requires an explicit scope decision.
