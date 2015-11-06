/**
  * Vampire-Werewolf problem definition
  */

%All valid states.
valid(3,3).
valid(3,2).
valid(3,1).
valid(3,0).
valid(2,2).
valid(1,1).
valid(0,3).
valid(0,2).
valid(0,1).
valid(0,0).

%State definition: [V, W, B]
/*
  V: Number of vampires on the left side.
  W: Number of werewolves on the left side.
  B: Either left or right; The position of the boat.
 */

start([3,3,left]).
goal([0,0,_]).

arc([V_start, W_start, left],[V_end, W_end, right]) :-
	valid(V_end, W_end),
	V_end is V_start - 1,
	W_end is W_start.
arc([V_start, W_start, left],[V_end, W_end, right]) :-
	valid(V_end, W_end),
	V_end is V_start,
	W_end is W_start - 1.
arc([V_start, W_start, left],[V_end, W_end, right]) :-
	valid(V_end, W_end),
	V_end is V_start - 2,
	W_end is W_start.
arc([V_start, W_start, left],[V_end, W_end, right]) :-
	valid(V_end, W_end),
	V_end is V_start - 1,
	W_end is W_start - 1.
arc([V_start, W_start, left],[V_end, W_end, right]) :-
	valid(V_end, W_end),
	V_end is V_start,
	W_end is W_start - 2.
arc([V_start, W_start, right],[V_end, W_end, left]) :-
	valid(V_end, W_end),
	V_end is V_start + 2,
	W_end is W_start.
arc([V_start, W_start, right],[V_end, W_end, left]) :-
	valid(V_end, W_end),
	V_end is V_start + 1,
	W_end is W_start + 1.
arc([V_start, W_start, right],[V_end, W_end, left]) :-
	valid(V_end, W_end),
	V_end is V_start,
	W_end is W_start + 2.
arc([V_start, W_start, right],[V_end, W_end, left]) :-
	valid(V_end, W_end),
	V_end is V_start + 1,
	W_end is W_start.
arc([V_start, W_start, right],[V_end, W_end, left]) :-
	valid(V_end, W_end),
	V_end is V_start,
	W_end is W_start + 1.
