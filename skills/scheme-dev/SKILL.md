---
name: scheme-dev
description: Guidelines, strict built-in allowlist, testing workflow, and self-review checklist for Racket 8.x (#lang racket/base) functional programming tasks in CS F301 Assignment 2 (S1 and S2).
---

# Scheme Development Skill (`Racket 8.x` — `#lang racket/base`)

## 1. Environment & Strict Built-in Allowlist
- **Runtime:** Racket 8.x.
- **Header:** Every `.rkt` submission file must begin with `#lang racket/base` on line 1.
- **Top-level purity:** Submission files (`26_q3.rkt`, `26_q4.rkt`) must contain **only definitions** (`define`). Never include top-level function calls, test expressions, or `display` calls, as the grader appends its own calls to the end of the file.
- **Allowed built-ins ONLY:**
  - Binding & control: `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` (with `else`), `and`, `or`, `not`, `begin`, `quote` (`'`).
  - Pairs & lists: `cons`, `car`, `cdr`, `list`, and `car`/`cdr` compositions up to 4 levels (`cadr`, `cddr`, `caddr`, `cdddr`, `cadddr`, `cddddr`, etc.).
  - Predicates & lookup: `null?`, `pair?`, `eq?`, `assq`, `assoc`.
  - Arithmetic & comparison: `+`, `-`, `*`, `/`, `<`, `>`, `<=`, `>=`, `=`, `max`.
  - I/O: `display`, `newline`, and `read` (**S2 only**).
- **Strictly forbidden:**
  - Mutation & data structures: `set!`, `set-car!`, `set-cdr!`, vectors, hash tables, strings.
  - Iteration & standard list helpers: `do`, `for`, `for/*`, `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `equal?`, `list-ref`, `list-tail`, `apply`.
  - Implement custom helpers (`my-length`, `my-map`, `my-reverse`, `my-append`) using only the allowlist above.

## 2. Decomposition Rule
- Work strictly **one unit of work per prompt** (one helper or target function, one test file, or one code review).
- Never generate a complete multi-function problem solution in a single turn.

## 3. Coding Conventions
- **Naming:** Use `kebab-case` for all functions, parameters, and helpers (e.g., `my-length`, `print-inorder`, `make-inserter`).
- **Documentation:** Above every function, include a brief comment specifying:
  - Contract / type signature (e.g., `; my-length : list -> exact-nonnegative-integer`).
  - Recursive or structural reading (base case, inductive step, and accumulator invariant if tail-recursive).
- **Recursion & Performance:**
  - Prefer tail recursion with an accumulator (using named `let` or a helper) for linear list operations (`my-length`, `my-map`, `my-reverse`, `my-append`).
  - Hidden tests in S2 include nesting depth **100** and flat lists of **10,000 elements**; linear list traversals must not overflow the call stack.
- **S2 Final Definition Rule:** In `26_q4.rkt`, ensure there is only **one** definition of `insert-if-short`—the final version defined in terms of `make-inserter`.

## 4. Running & Testing
Run from the repository root (CS301-Assignment2), unless otherwise specified
- **Direct execution (verifies zero output on load):**
  ```bash
  racket code/26_q3.rkt
  racket code/26_q4.rkt
  ```

- **Testing S1: (run from inside /tests)**
  { cat ../code/26_q3.rkt; tail -n +2 test_q3.rkt; } > /tmp/run_q3.rkt && racket /tmp/run_q3.rkt && rm /tmp/run_q3.rkt

- **Testing S2: (run from root)**
  { cat code/26_q4.rkt; echo "(print-insert-result)"; } > /tmp/run_q4.rkt && echo "42 ((1 2) (3 4 5) (6) ()) 3" | racket /tmp/run_q4.rkt && rm /tmp/run_q4.rkt
  { cat code/26_q4.rkt; echo "(print-insert-result) (print-insert-result) (print-insert-result)"; } > /tmp/run_q4.rkt && printf "0 (((1) 2) (3) ((4 5 6) ())) 3\n7 () 3\n7 () 0\n" | racket /tmp/run_q4.rkt && rm /tmp/run_q4.rkt

## 5. Self-Review Checklist (Apply Before Finalizing Any Response)
1. **Unit scope:** Does this response implement or review only the single requested function or test file?
2. **Allowlist audit:** Scan every identifier in the code—is every non-local symbol strictly in the Section 1 allowlist?
3. **File cleanliness:** Does the file start with `#lang racket/base` and contain zero top-level calls or prints?
4. **Stack safety:** Are `my-length` and `my-map` tail-recursive (accumulator + reverse) so 10,000-element lists succeed without stack overflow?
5. **Specification edge cases:**
   - S1: Does `'()` print `()` for traversals and `(0 0)` for `print-height-and-leaves`? Does every print function end with `(newline)`?
   - S2: Is list length computed on the **original** list before prepending `x`? Does `'()` have length `0` and become `(x)` when `(len-ok? 0)` holds, including at the top level? Is `insert-if-short` defined once using `make-inserter`?

## 6. Known AI Failure Modes in Racket (`#lang racket/base`)
- **Calling forbidden standard library functions:** Accidentally using `append`, `reverse`, `length`, `map`, `equal?`, or `add1`/`sub1` (use `(+ x 1)` and `(- x 1)` instead of `add1`/`sub1`, which are not on the allowlist).
- **Using `#lang racket` instead of `#lang racket/base`:** `#lang racket` loads extra bindings that mask allowlist violations during local testing and fail grading checks.
- **Deep `c...r` chains:** Using 5-level accessors like `caddddr`, which exceed the 4-level limit (`cadr`, `caddr`, `cadddr`, etc.).
- **Non-tail-recursive `my-map` / `my-length`:** Writing `(cons (f (car lst)) (my-map f (cdr lst)))` blows the stack on 10,000-element lists in S2; accumulate in reverse with a named `let` and reverse with `my-reverse`.
- **Leaving top-level calls in `.rkt` files:** Leaving `(print-inorder t1)` at the bottom of `id_q3.rkt`, causing unexpected output before the grader's own test calls run.
- **Duplicate `insert-if-short` definitions in S2:** Keeping both the S2.b direct version and the S2.c `make-inserter` version in `id_q4.rkt`.