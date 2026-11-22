:- use_module(library(lists)).
:- consult('../code/26_q1.pl').

% check(+Label, +Goal)
% Declarative reading: Succeeds and prints a pass message if Goal succeeds;
% otherwise prints a failure message and fails.
check(Label, Goal) :-
    (   call(Goal)
    ->  format('PASS: ~w~n', [Label])
    ;   format('FAIL: ~w~n', [Label]),
        fail
    ).

% test_valid_solution
% Declarative reading: Verifies that valid_solution/1 generates all 13,824
% distinct permutations and rejects duplicate attribute assignments.
test_valid_solution :-
    check('valid_solution total count is 13824',
          (findall(S, valid_solution(S), Ls), length(Ls, 13824))),
    check('valid_solution accepts a valid assignment',
          valid_solution([
              p('Alex',  research,    python,     'AI'),
              p('Ben',   development, java,       web),
              p('Carla', design,      'c++',      embedded),
              p('Dana',  testing,     javascript, data)
          ])),
    check('valid_solution rejects duplicate department',
          \+ valid_solution([
              p('Alex',  research,    python,     'AI'),
              p('Ben',   research,    java,       web),
              p('Carla', design,      'c++',      embedded),
              p('Dana',  testing,     javascript, data)
          ])).

% test_clues
% Declarative reading: Verifies positive and negative cases for each
% individual clause clue(1, Solution) through clue(9, Solution).
test_clues :-
    Base = [
        p('Alex',  design,      java,       embedded),
        p('Ben',   development, javascript, web),
        p('Carla', testing,     python,     'AI'),
        p('Dana',  research,    'c++',      data)
    ],
    check('clue 1 positive', clue(1, Base)),
    check('clue 1 rejects AI in research',
          \+ clue(1, [
              p('Alex',  research,    java,       'AI'),
              p('Ben',   development, javascript, web),
              p('Carla', testing,     python,     embedded),
              p('Dana',  design,      'c++',      data)
          ])),
    check('clue 1 rejects Dana with AI',
          \+ clue(1, [
              p('Alex',  design,      java,       embedded),
              p('Ben',   development, javascript, web),
              p('Carla', testing,     python,     data),
              p('Dana',  research,    'c++',      'AI')
          ])),
    check('clue 2 positive', clue(2, Base)),
    check('clue 2 rejects Alex in development',
          \+ clue(2, [
              p('Alex',  development, java,       embedded),
              p('Ben',   design,      javascript, web),
              p('Carla', testing,     python,     'AI'),
              p('Dana',  research,    'c++',      data)
          ])),
    check('clue 2 rejects Alex with c++',
          \+ clue(2, [
              p('Alex',  design,      'c++',      embedded),
              p('Ben',   development, javascript, web),
              p('Carla', testing,     python,     'AI'),
              p('Dana',  research,    java,       data)
          ])),
    check('clue 3 positive', clue(3, Base)),
    check('clue 3 rejects testing without python',
          \+ clue(3, [
              p('Alex',  design,      java,       embedded),
              p('Ben',   development, javascript, web),
              p('Carla', testing,     'c++',      'AI'),
              p('Dana',  research,    python,     data)
          ])),
    check('clue 4 positive', clue(4, Base)),
    check('clue 4 rejects Ben in testing',
          \+ clue(4, [
              p('Alex',  design,      java,       embedded),
              p('Ben',   testing,     python,     web),
              p('Carla', development, javascript, 'AI'),
              p('Dana',  research,    'c++',      data)
          ])),
    check('clue 5 positive', clue(5, Base)),
    check('clue 5 rejects java outside design',
          \+ clue(5, [
              p('Alex',  research,    java,       embedded),
              p('Ben',   development, javascript, web),
              p('Carla', testing,     python,     'AI'),
              p('Dana',  design,      'c++',      data)
          ])),
    check('clue 6 positive', clue(6, Base)),
    check('clue 6 rejects Carla with embedded',
          \+ clue(6, [
              p('Alex',  design,      java,       'AI'),
              p('Ben',   development, javascript, web),
              p('Carla', testing,     python,     embedded),
              p('Dana',  research,    'c++',      data)
          ])),
    check('clue 6 rejects Carla in development',
          \+ clue(6, [
              p('Alex',  design,      java,       embedded),
              p('Ben',   testing,     python,     web),
              p('Carla', development, javascript, 'AI'),
              p('Dana',  research,    'c++',      data)
          ])),
    check('clue 7 positive', clue(7, Base)),
    check('clue 7 rejects Dana in design',
          \+ clue(7, [
              p('Alex',  research,    'c++',      embedded),
              p('Ben',   development, javascript, web),
              p('Carla', testing,     python,     'AI'),
              p('Dana',  design,      java,       data)
          ])),
    check('clue 8 positive', clue(8, Base)),
    check('clue 8 rejects data with javascript',
          \+ clue(8, [
              p('Alex',  design,      java,       embedded),
              p('Ben',   development, 'c++',      web),
              p('Carla', testing,     python,     'AI'),
              p('Dana',  research,    javascript, data)
          ])),
    check('clue 9 positive', clue(9, Base)),
    check('clue 9 rejects AI outside testing',
          \+ clue(9, [
              p('Alex',  testing,     python,     embedded),
              p('Ben',   development, javascript, web),
              p('Carla', design,      java,       'AI'),
              p('Dana',  research,    'c++',      data)
          ])).

% test_solve_and_counts
% Declarative reading: Verifies solve/1 and count_solutions/2 for empty clues,
% clues 1..8 (N = 3), and clues 1..9 (N = 1).
test_solve_and_counts :-
    check('solve/1 produces a valid solution',
          (solve(S), valid_solution(S))),
    check('count_solutions([], 13824)',
          count_solutions([], 13824)),
    check('count_solutions([1,2,3,4,5,6,7,8], 3)',
          count_solutions([1,2,3,4,5,6,7,8], 3)),
    check('count_solutions([1,2,3,4,5,6,7,8,9], 1)',
          count_solutions([1,2,3,4,5,6,7,8,9], 1)),
    check('unique solution under clues 1..9 matches expected assignment',
          (   valid_solution(Unique),
              satisfies_clues([1,2,3,4,5,6,7,8,9], Unique),
              Unique == [
                  p('Alex',  design,      java,       embedded),
                  p('Ben',   development, javascript, web),
                  p('Carla', testing,     python,     'AI'),
                  p('Dana',  research,    'c++',      data)
              ]
          )).

% run_tests
% Declarative reading: Executes all P1 test suites and succeeds if and only if
% every check passes.
run_tests :-
    test_valid_solution,
    test_clues,
    test_solve_and_counts,
    format('All P1 tests passed.~n', []).