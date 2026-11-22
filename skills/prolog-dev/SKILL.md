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
Run from the repository root (CS301-Assignment2).
Source files are located in `code/` and test files in `tests/`.

- **Run `main/0` (P1):**
  `swipl -q -f code/26_q1.pl -g main -t halt`
- **Run a specific goal / test query:**
  `swipl -q -f code/26_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8], N), writeln(N)" -t halt`
  `swipl -q -f code/26_q2.pl -g "all_equations([4,2,5,3], Es), writeln(Es)" -t halt`
- **Run unit test files (`tests/`):**
  `swipl -q -f tests/test_q1.pl -g run_tests -t halt`
  `swipl -q -f tests/test_q2.pl -g run_tests -t halt`


## 5. Self-Review Checklist (Apply Before Finalizing Any Response)
1. **Unit scope:** Does this response implement or review only a single requested unit of work?
2. **Purity & Directives:** Are `assert`, `retract`, `b_setval`, `nb_setval`, `halt/0`, and `:- initialization(...)` completely absent?
3. **Libraries:** Are only `lists`, `apply`, `yall`, and/or `aggregate` imported?
4. **Declarative comments:** Does every predicate have a clear declarative reading comment?
5. **Types & Formatting (P1 & P2):**
   - P1: Are `'Alex'`, `'AI'`, and `'c++'` properly quoted? Does `main/0` print the exact 8-line format with no extra spaces or debug text?
   - P2: Are equations returned as SWI-Prolog **strings** (`"..."`), not atoms (`'...'`) or code lists?
6. **Edge Cases & Termination:**
   - P2: Does `generate_equation/2` fail cleanly (without looping or throwing) on `[]`, `[X]`, or unsolvable lists? Does `all_equations/2` return `[]` on unsolvable lists and sort/deduplicate with `sort/2`?
   - P2: Is division guarded against zero divisors (`D =\= 0`) and non-zero remainders (`N mod D =:= 0`) at **every** intermediate step?
7. **Canonical Formatting (P2):**
   - Multiplication and division have higher precedence than addition and subtraction.
   - All operators are left-associative.
   - Parenthesize a left child only when its top operator has lower precedence than its parent.
   - Parenthesize a right child when its top operator has equal or lower precedence than its parent.
   - Never parenthesize a single number.
   - Different expression trees must produce different strings.
8. **P2 Expected Results:**
   - `all_equations([4,2,5,3], Es)` returns exactly 7 equations.
   - `all_equations([2,3,4], Es)` returns `[]`.
   - `all_equations([2,4,8], Es)` returns `["2*4=8"]`.
   - `all_equations([], Es)` returns `[]`.
   - `count_equations([4,2,5,3], N)` returns `N = 7`.
   - `count_equations([], N)` returns `N = 0`.



## 6. Known AI Failure Modes in Prolog
- **Unquoted special atoms:** Writing `Alex`, `AI`, or `c++` instead of `'Alex'`, `'AI'`, `'c++'`, silently turning `Alex`/`AI` into unbound variables and causing syntax errors on `c++`.
- **Atoms vs. Strings in P2:** Returning `'4*2=5+3'` (atom) instead of `"4*2=5+3"` (SWI-Prolog string). Use `string_concat/3`, `number_string/2`, or `format(string(S), ...)` to construct strings directly from AST nodes.
- **Calling `halt/0` inside `main/0`:** Causes `swipl` to exit abruptly in interactive sessions or interfere with `-t halt`.
- **Arithmetic evaluation errors (`is/2`):** Performing `X // Y` before checking `Y =\= 0` and `X mod Y =:= 0`, causing `zero_divisor` exceptions or silently truncating non-exact division.
- **Parenthesization bugs in P2:** Failing to parenthesize right operands of equal precedence under left-associative operators (e.g., rendering `1-(2-3)` as `1-2-3` or `8/(4*2)` as `8/4*2`), or over-parenthesizing left operands of equal precedence (e.g., rendering `(1+2)+3` instead of `1+2+3`).
- **Missing `sort/2` deduplication:** Returning duplicate equation strings in `all_equations/2` when distinct derivations yield identical canonical strings.