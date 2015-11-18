General purpose prolog search
******************************************
This solver was created with SWI-Prolog.

Authors:
Dan Green
Katelyn Narum
******************************************

To begin, load the solver file with the following command:
?- ['solver.pl'].

Once solver has loaded, use the solve/2 predicate to start the search.

solve(++Puzzle, ++Strategy):
  This will load the files associated with both the puzzle
  and strategy, and will start the solver.
  Output will go to the appropriate file rather than to
  the screen.

Example use:
?- solve(vampwolf, dfs).


The available puzzles are:
----------------------------------
vampwolf: Vampire/Werewolf puzzle
blackwhite: Black-White puzzle

The available strategies are:
----------------------------------
bfs: Breadth-first search
dfs: Depth-first search
hfs: Heuristic-first search

Continuing unification (by pressing ;) will find paths to additional goal states
if more than one goal state is defined. In the output file, these solutions are
separated by a horizontal line.
