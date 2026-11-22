# P1 Report: Department Assignment Puzzle Analysis

## 1. Number of Solutions for Clues 1 to 8
Running `count_solutions([1,2,3,4,5,6,7,8], N)` produces:

**`N = 3`**

## 2. All Valid Solutions under Clues 1 to 8

| Friend | Solution 1 | Solution 2 | Solution 3 |
| :--- | :--- | :--- | :--- |
| **Alex** | `[design, java, AI]` | `[design, java, embedded]` | `[testing, python, embedded]` |
| **Ben** | `[development, javascript, web]` | `[development, javascript, web]` | `[development, javascript, web]` |
| **Carla** | `[research, c++, data]` | `[testing, python, AI]` | `[design, java, AI]` |
| **Dana** | `[testing, python, embedded]` | `[research, c++, data]` | `[research, c++, data]` |

## 3. What This Tells Us About the Puzzle

1. **Consistent but Under-Constrained:**
   Because $N = 3 > 0$, clues 1 through 8 contain no logical contradictions. However, because $N > 1$, the puzzle is **under-constrained** and does not yield a unique solution.

2. **Uniquely Determined Attribute Bundles:**
   Across all three solutions, **Ben** is completely fixed as `[development, javascript, web]`, and the remaining departments and languages are locked into fixed pairings:
   - `design` is always paired with `java`.
   - `testing` is always paired with `python`.
   - `research` is always paired with `c++` and `data`.

3. **Remaining Degrees of Freedom:**
   - **Assignment of `(research, c++, data)`:** Clues 6, 7, and 8 leave open whether this bundle belongs to **Carla** (Solution 1) or **Dana** (Solutions 2 and 3).
   - **Pairing of `AI` and `embedded`:** Clues 1–8 do not specify whether `AI` goes to the `design`/`java` person and `embedded` goes to the `testing`/`python` person (Solutions 1 and 3), or vice versa (Solution 2).

4. **Implication for Repairing the Puzzle (Clue 9):**
   Notice that **Solution 1 and Solution 3 have the exact same set of attribute triples**—they only differ in whether Alex or Carla takes `(design, java, AI)` vs. `(testing, python, embedded)`. Because Clue 9 is restricted to referencing attribute values without naming any friend, **only Solution 2 can be uniquely isolated** (for example, by linking `design`/`java` with `embedded`, or `testing`/`python` with `AI`).