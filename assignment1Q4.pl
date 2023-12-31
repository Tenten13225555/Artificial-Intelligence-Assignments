% Custom predicate for “is less than”
my_is_less_than(0, X) :- X \== 0.
my_is_less_than(X, Y) :-
    X > 0, Y > 0,
    X1 is X - 1,
    Y1 is Y - 1,
    my_is_less_than(X1, Y1).

% Custom predicate for “is”
my_is(X, X).

% Custom predicate for multiplication
my_multiply(0, _, 0).
my_multiply(X, Y, Z) :-
    X \== 0,
    X1 is X - 1,
    my_multiply(X1, Y, Z1),
    Z is Z1 + Y.

% If N is less than 0, then no factorial exists, so fail
my_fact(N, _) :-
    my_is_less_than(N, 0),
    !, fail.

% Base case: factorial of 0 is 1
my_fact(0, 1) :- !.

% Recursive case: factorial of N is N * factorial of (N - 1)
my_fact(N, R) :-
    N1 is N - 1,
    my_fact(N1, Res),
    my_multiply(N, Res, R).
