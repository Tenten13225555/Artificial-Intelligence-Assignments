% Define edges of the graph
edge(a,b).
edge(b,c).
edge(c,d).
edge(a,e).
edge(e,f).
edge(f,g).

% Base case: An acyclic path from A to A is a list containing just A
find_path(A, A, Visited, Path) :- reverse([A|Visited], Path).

% Recursive case: Find an acyclic path from A to Z
find_path(A, Z, Visited, Path) :-
    \+ member(A, Visited), % Ensure A has not been visited yet
    edge(A, Next),         % There exists an edge from A to Next
    find_path(Next, Z, [A|Visited], Path). % Recur with Next as the new starting point

% Wrapper function to initiate the search
find_path(A, Z, Path) :- find_path(A, Z, [], Path).
