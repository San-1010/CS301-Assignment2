:- use_module(library(lists)).
:- consult('../code/26_q2.pl').

% check(+Label, +Goal)
% Declarative reading: Succeeds and prints a pass message if Goal succeeds;
% otherwise prints a failure message and fails.
check(Label, Goal) :-
    (   call(Goal)
    ->  format('PASS: ~w~n', [Label])
    ;   format('FAIL: ~w~n', [Label]),
        fail
    ).

% run_tests
% Declarative reading: Executes all P2 test cases and succeeds if and only if
% every check passes.
run_tests :-
    % Check all seven expected equations.
    check(seven_equations,
          (   all_equations([4,2,5,3], Es),
              Es = ["4*2-5=3", "4*2=5+3",
                    "4-2=5-3", "4/2=5-3",
                    "4=2*(5-3)", "4=2+(5-3)",
                    "4=2+5-3"]
          )),

    % No valid equations.
    check(no_equations,
          all_equations([2,3,4], [])),

    % Exactly one valid equation.
    check(single_equation,
          all_equations([2,4,8], ["2*4=8"])),

    % Empty input list.
    check(empty_list,
          all_equations([], [])),

    % Single number cannot form an equation.
    check(single_number,
          all_equations([4], [])),

    % Count seven equations.
    check(count_seven,
          count_equations([4,2,5,3], 7)),

    % Count zero equations.
    check(count_zero,
          count_equations([2,3,4], 0)),

    % Count one equation.
    check(count_one,
          count_equations([2,4,8], 1)),

    % Generate one valid equation.
    check(generate_valid,
          (   once(generate_equation([4,2,5,3], E)),
              member(E, ["4*2-5=3", "4*2=5+3",
                         "4-2=5-3", "4/2=5-3",
                         "4=2*(5-3)", "4=2+(5-3)",
                         "4=2+5-3"])
          )),

    % No equation exists.
    check(generate_invalid,
          \+ generate_equation([2,3,4], _)),

    % Empty list must fail.
    check(generate_empty,
          \+ generate_equation([], _)),

    % Single-number list must fail.
    check(generate_single,
          \+ generate_equation([4], _)),

    % Exact integer division.
    check(exact_division,
          apply_operator('/', 8, 4, 2)),

    % Non-exact division must fail.
    check(inexact_division,
          \+ apply_operator('/', 7, 2, _)),

    % Division by zero must fail.
    check(division_by_zero,
          \+ apply_operator('/', 8, 0, _)),

    % Negative intermediate values are allowed.
    check(negative_intermediate,
          expression([3,5],
                     node('-',leaf(3),leaf(5)),
                     -2)),

    % Correct parentheses around addition.
    check(parentheses,
          format_expression(
              node('*',
                   node('+',leaf(4),leaf(2)),
                   leaf(3)),
              "(4+2)*3")),

    % Right-nested addition requires parentheses.
    check(right_associativity,
          format_expression(
              node('+',
                   leaf(1),
                   node('+',leaf(2),leaf(3))),
              "1+(2+3)")),

    format('All P2 tests passed.~n', []).