% Define the initial state and the goal state.
initial_state(state(e, e, e, e)).
goal_state(state(w, w, w, w)).

% Check if a given state is safe.
is_safe(state(FP, GP, WP, CP)) :-
    (GP \= WP ; FP = WP),   % If goat and wolf are on different shores, or if they're on the same shore as the farmer.
    (GP \= CP ; FP = CP).   % If goat and cabbage are on different shores, or if they're on the same shore as the farmer.

% Possible moves:
% Farmer can move alone.
move(state(FP, GP, WP, CP), state(NP, GP, WP, CP)) :- opposite(FP, NP).

% Farmer can move with the goat.
move(state(FP, FP, WP, CP), state(NP, NP, WP, CP)) :- opposite(FP, NP).

% Farmer can move with the wolf.
move(state(FP, GP, FP, CP), state(NP, GP, NP, CP)) :- opposite(FP, NP).

% Farmer can move with the cabbage.
move(state(FP, GP, WP, FP), state(NP, GP, WP, NP)) :- opposite(FP, NP).

% Helper predicate to determine opposite shores.
opposite(e, w).
opposite(w, e).

% Depth-first search with cycle detection.
dfs(Current, _, Path, Path) :- goal_state(Current).  % If the current state is the goal state, we are done.
dfs(Current, Visited, _, _) :-
    member(Current, Visited), !, fail. % If we've seen this state before, cut and fail.
dfs(Current, Visited, CurrentPath, Solution) :-
    move(Current, NextState),
    is_safe(NextState),
    dfs(NextState, [Current|Visited], [NextState|CurrentPath], Solution).

% Main function to find the solution using DFS
find_dfs_solution :-
    initial_state(Start),
    dfs(Start, [], [Start], Solution),
    write('DFS Solution: '), write(Solution), nl.


