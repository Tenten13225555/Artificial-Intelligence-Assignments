% Custom predicate for equality
my_equal(X, X).

% Custom predicate for incrementing a number
my_increment(X, Y) :- Y is X + 1.

% Custom predicate for appending to a list
my_append([], X, [X]).
my_append([H|T], X, [H|NewT]) :- my_append(T, X, NewT).

% Base case: the list is empty, so the result is also an empty list
find_positions(_, [], _, []).

% Recursive case 1: the current element matches x
% Add the current index to the result list
find_positions(X, [X|T], Index, [Index|NewT]) :-
    my_increment(Index, NewIndex),
    find_positions(X, T, NewIndex, NewT).

% Recursive case 2: the current element does not match x
% Do not add the current index to the result list
find_positions(X, [H|T], Index, NewT) :-
    \+ my_equal(X, H),
    my_increment(Index, NewIndex),
    find_positions(X, T, NewIndex, NewT).

% Wrapper predicate to start the index at 1
find_positions(X, L, R) :- find_positions(X, L, 1, R).

