
% split_nonempty(List, Left, Right) holds when
% List is the concatenation of two nonempty consecutive
% lists Left and Right, preserving the original order.

split_nonempty(List, Left, Right) :-
    append(Left, Right, List),
    Left = [_|_],
    Right = [_|_].

% apply_operator(Op, A, B, Result) holds when
% Result is the integer obtained by applying operator Op
% to integer operands A and B. Division is permitted
% only when B is nonzero and A is exactly divisible by B.

apply_operator(+, A, B, Result) :-
    Result is A + B.

apply_operator(-, A, B, Result) :-
    Result is A - B.

apply_operator(*, A, B, Result) :-
    Result is A * B.

apply_operator(/, A, B, Result) :-
    B =\= 0,
    0 is A mod B,
    Result is A // B.


% expression(Numbers, Tree, Value) holds when Tree is a
% binary arithmetic expression using every number in
% Numbers exactly once and in the original order, and
% Value is its integer result. All divisions are exact.

expression([N], leaf(N), N) :-
    integer(N).

expression(Numbers, node(Op, LeftTree, RightTree), Value) :-
    split_nonempty(Numbers, LeftNumbers, RightNumbers),
    expression(LeftNumbers, LeftTree, LeftValue),
    expression(RightNumbers, RightTree, RightValue),
    member(Op, [+, -, *, /]),
    apply_operator(Op, LeftValue, RightValue, Value).


% operator_precedence(Op, P) holds when P is the
% precedence level of arithmetic operator Op.
% Higher numbers indicate stronger binding.

operator_precedence(+, 1).
operator_precedence(-, 1).
operator_precedence(*, 2).
operator_precedence(/, 2).

% format_expression(Tree, String) holds when String
% is the canonical, space-free arithmetic representation
% of Tree, respecting precedence and left associativity.

format_expression(leaf(N), String) :-
    integer(N),
    number_string(N, String).

format_expression(node(Op, Left, Right), String) :-
    operator_precedence(Op, ParentPrec),
    format_expression(Left, LeftString),
    format_expression(Right, RightString),
    format_child(Left, LeftString, ParentPrec, left, LText),
    format_child(Right, RightString, ParentPrec, right, RText),
    atom_string(Op, OpString),
    string_concat(LText, OpString, Temp),
    string_concat(Temp, RText, String).

% format_child(Tree, Text, ParentPrec, Side, Result)
% holds when Result is Text surrounded by parentheses
% exactly when the child's precedence and position
% require them in the parent expression.

format_child(leaf(_), Text, _, _, Text).

format_child(node(Op, _, _), Text, ParentPrec, Side, Result) :-
    operator_precedence(Op, ChildPrec),
    (   ChildPrec < ParentPrec
    ;   Side == right,
        ChildPrec =:= ParentPrec
    ),
    !,
    string_concat("(", Text, Temp),
    string_concat(Temp, ")", Result).

format_child(node(_, _, _), Text, _, _, Text).
