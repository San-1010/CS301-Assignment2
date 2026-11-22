
% split_nonempty(List, Left, Right) holds when
% List is the concatenation of two nonempty consecutive
% lists Left and Right, preserving the original order.

split_nonempty(List, Left, Right) :-
    append(Left, Right, List),
    Left = [_|_],
    Right = [_|_].
