/**
  * Depth-First Search strategy definition
  */

empty_stack([]).
stack(E, S, [E | S]).

begin(Start, Goal, Filename) :-
	empty_stack(Empty_been_list),
	stack(Start, Empty_been_list, Been_list),
	open(Filename, append, Stream),
	path(Start, Goal, Been_list, Stream),
	write(Stream, '--------------'), nl(Stream),
	close(Stream).
	
	% path implements a depth first search in PROLOG
	
	% Current state = goal, print out been list

path(Goal, Goal, Been_list, Stream) :-
	write(Stream, 'States Visited:'), nl(Stream),
	print_visited(Been_list, Stream), nl(Stream),
	write(Stream, 'Solution:'), nl(Stream),
	reverse_print_stack(Been_list, Stream).
	
path(State, Goal, Been_list, Stream) :-
	arc(State, Next, _),
	% not(unsafe(Next)),
	not(member(Next, Been_list)),
	stack(Next, Been_list, New_been_list),
	path(Next, Goal, New_been_list, Stream), !.
	
reverse_print_stack(S, _) :-
	empty_stack(S).
reverse_print_stack(S, Stream) :-
	stack(E, Rest, S),
	reverse_print_stack(Rest, Stream),
	write(Stream, E), nl(Stream).

print_visited([], _).
print_visited([H|Closed], Stream) :-
	print_visited(Closed, Stream),
	write(Stream, H), nl(Stream).