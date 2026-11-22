:- use_module(library(lists)).

% valid_solution(?Solution)
% Declarative reading: Solution is a list of four p(Name, Dept, Lang, Project)
% structures for 'Alex', 'Ben', 'Carla', and 'Dana' (in that fixed order)
% such that the assigned departments, favorite languages, and project
% preferences are each a permutation of their respective four-element domain.
valid_solution(Solution) :-
    Solution = [
        p('Alex',  D1, L1, P1),
        p('Ben',   D2, L2, P2),
        p('Carla', D3, L3, P3),
        p('Dana',  D4, L4, P4)
    ],
    permutation([research, development, design, testing], [D1, D2, D3, D4]),
    permutation([python, java, 'c++', javascript], [L1, L2, L3, L4]),
    permutation(['AI', web, embedded, data], [P1, P2, P3, P4]).


% clue(+N, +Solution)
% Declarative reading: Clue number N (for N in 1..8) is satisfied by the
% complete candidate assignment Solution of four p(Name, Dept, Lang, Project) terms.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Dept \= research,
    Name \= 'Dana'.

clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \= development,
    Lang \= 'c++'.

clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \= testing.

clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

clue(6, Solution) :-
    member(p('Carla', Dept, _, Proj), Solution),
    Proj \= embedded,
    Dept \= development.

clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \= java,
    member(Dept, [research, testing]).

clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.