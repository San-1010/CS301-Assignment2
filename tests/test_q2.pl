
:- begin_tests(q2).

:- consult('../code/26_q2.pl').

% Check all seven expected equations.
test(seven_equations) :-
    all_equations([4,2,5,3], Es),
    Es = ["4*2-5=3", "4*2=5+3",
          "4-2=5-3", "4/2=5-3",
          "4=2*(5-3)", "4=2+(5-3)",
          "4=2+5-3"].

% No valid equations.
test(no_equations) :-
    all_equations([2,3,4], []).

% Exactly one valid equation.
test(single_equation) :-
    all_equations([2,4,8], ["2*4=8"]).

% Empty input list.
test(empty_list) :-
    all_equations([], []).

% Single number cannot form an equation.
test(single_number) :-
    all_equations([4], []).

% Count seven equations.
test(count_seven) :-
    count_equations([4,2,5,3], 7).

% Count zero equations.
test(count_zero) :-
    count_equations([2,3,4], 0).

% Count one equation.
test(count_one) :-
    count_equations([2,4,8], 1).

% Generate one valid equation.
test(generate_valid, [nondet]) :-
    once(generate_equation([4,2,5,3], E)),
    member(E, ["4*2-5=3", "4*2=5+3",
               "4-2=5-3", "4/2=5-3",
               "4=2*(5-3)", "4=2+(5-3)",
               "4=2+5-3"]).

% No equation exists.
test(generate_invalid, [fail]) :-
    generate_equation([2,3,4], _).

% Empty list must fail.
test(generate_empty, [fail]) :-
    generate_equation([], _).

% Single-number list must fail.
test(generate_single, [fail]) :-
    generate_equation([4], _).

% Exact integer division.
test(exact_division) :-
    apply_operator('/', 8, 4, 2).

% Non-exact division must fail.
test(inexact_division, [fail]) :-
    apply_operator('/', 7, 2, _).

% Division by zero must fail.
test(division_by_zero, [fail]) :-
    apply_operator('/', 8, 0, _).

% Negative intermediate values are allowed.
test(negative_intermediate, [nondet]) :-
    expression([3,5],
               node('-',leaf(3),leaf(5)),
               -2).

% Correct parentheses around addition.
test(parentheses) :-
    format_expression(
        node('*',
             node('+',leaf(4),leaf(2)),
             leaf(3)),
        "(4+2)*3").

% Right-nested addition requires parentheses.
test(right_associativity) :-
    format_expression(
        node('+',
             leaf(1),
             node('+',leaf(2),leaf(3))),
        "1+(2+3)").

:- end_tests(q2).
