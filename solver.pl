/**
  * Search problem solver
  * (Requires a Puzzle and a Strategy)
  */

outputFileName(vampwolf, dfs, 'vamp-wolf-dfs.txt').
outputFileName(vampwolf, bfs, 'vamp-wolf-bfs.txt').
outputFileName(vampwolf, hfs, 'vamp-wolf-hfs.txt').
outputFileName(blackwhite, dfs, 'black-white-bfs.txt').
outputFileName(blackwhite, bfs, 'black-white-dfs.txt').
outputFileName(blackwhite, hfs, 'black-white-hfs.txt').

dfs :- ['strategies/dfs.pl'].
bfs :- ['strategies/bfs.pl'].
hfs :- ['strategies/hfs.pl'].

vampwolf :- ['puzzles/vamp-wolf.pl'].
blackwhite :- ['puzzles/black-white.pl'].

solve(Puzzle, Strategy) :-
	Puzzle, Strategy,
	outputFileName(Puzzle, Strategy, Filename),
	start(S), goal(G), begin(S, G, Filename).