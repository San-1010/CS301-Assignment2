---
name: scheme-dev
description: Guidelines, strict built-in allowlist, testing workflow, and self-review checklist for Racket 8.x (#lang racket/base) functional programming tasks in CS F301 Assignment 2 (S1 and S2).
---

# Scheme Development Skill (`Racket 8.x` — `#lang racket/base`)

## 1. Environment & Strict Built-in Allowlist
- **Runtime:** Racket 8.x.
- **Header:** Every `.rkt` submission file must begin with `#lang racket/base` on line 1.
- **Top-level purity:** Submission files (`id_q3.rkt`, `id_q4.rkt`) must contain **only definitions** (`define`). Never include top-level function calls, test expressions, or `display` calls, as the grader appends its own calls to the end of the file.
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
- **S2 Final Definition Rule:** In `id_q4.rkt`, ensure there is only **one** definition of `insert-if-short`—the final version defined in terms of `make-inserter`.

## 4. Running & Testing
- **Direct execution (verifies zero output on load):**
  ```bash
  racket id_q3.rkt
  racket id_q4.rkt