---
name: prolog-dev
description: Guidelines, constraints, testing workflow, and self-review checklist for SWI-Prolog 9.x logic programming tasks in CS F301 Assignment 2 (P1 and P2).
---

# Prolog Development Skill (`SWI-Prolog 9.x`)

## 1. Environment & Allowed Libraries
- **Runtime:** SWI-Prolog 9.x (`swipl`).
- **Allowed libraries only:** `lists`, `apply`, `yall`, `aggregate` (load via `:- use_module(library(...)).`).
- **Strictly forbidden:**
  - Dynamic database or global state: `assert/1`, `asserta/1`, `assertz/1`, `retract/1`, `retractall/1`, `b_setval/2`, `nb_setval/2`.
  - Process control or load-time execution: `halt/0`, `halt/1`, or any `:- initialization(...)` directive.
  - String-to-term evaluation hacks (do not build an expression string and parse/evaluate it back).
  - Unrequested output: print nothing except what is explicitly required by `main/0` in P1.

## 2. Decomposition Rule
- Work strictly **one unit of work per prompt** (one predicate, one clue clause, one test file, or one code review).
- Never generate a complete multi-predicate problem solution in a single turn.

## 3. Coding Conventions
- **Naming:** Use `snake_case` for predicate and variable names (`UpperCamelCase` or `_` for Prolog variables).
- **Exact Atoms (P1):** Always single-quote capitalized or operator-containing atoms: `'Alex'`, `'Ben'`, `'Carla'`, `'Dana'`, `'AI'`, `'c++'`. Leave lowercase identifiers unquoted: `research`, `development`, `design`, `testing`, `python`, `java`, `javascript`, `web`, `embedded`, `data`.
- **Documentation:** Every predicate must have a concise comment stating its **declarative reading** (what logical relation holds between its arguments) and argument modes (`+`, `-`, `?`).
- **Clue 9 Comment (P1.c):** Place `% CLUE 9: <English sentence>` on the line immediately preceding `clue(9, Solution) :-`.

## 4. Running & Testing
Run from the directory containing 26_q1.pl` / `26_q2.pl`
- **Run `main/0` (P1):**
  ```bash
  swipl -q -f 26_q1.pl -g main -t halt