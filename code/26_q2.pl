
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
