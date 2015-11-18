/**
  * Breadth-First Search strategy definition
  */
empty_queue([]).
add_list_to_queue([], Q, Q).
add_list_to_queue([H|T], Queue, New_Queue) :-
	add_to_queue(H, Queue, TempQueue),
	add_list_to_queue(T, TempQueue, New_Queue).
add_to_queue(E, [], [E]).
add_to_queue(E, [H|T], [H|Tnew]) :- add_to_queue(E, T, Tnew).
remove_from_queue(E, [E|T], T).

empty_set([]).
add_to_set(X, S, S) :- member(X, S), !.
add_to_set(X, S, [X|S]).

state_record(State, Parent, [State, Parent]).

begin(Start, Goal, Filename) :-
	empty_queue(Empty_Open),
	empty_set(Closed),
	state_record(Start, nil, State),
	add_to_queue(State, Empty_Open, Open),
	open(Filename, append, Stream),
	search_step(Open, Closed, Goal, Stream),
	write(Stream, '--------------'), nl(Stream),
	close(Stream).

search_step(Open, _, _, Stream) :-
	empty_queue(Open),
	write(Stream, 'Empty Queue! No solution found.'), nl(Stream).
search_step(Open, Closed, Goal, Stream) :-
	remove_from_queue(Next_record, Open, _),
	state_record(State, _, Next_record),
	Goal = State,
	write(Stream, 'States Visited:'), nl(Stream),
	print_visited(Closed, Stream), nl(Stream),
	write(Stream, 'Solution:'), nl(Stream),
	print_solution(Next_record, Closed, Stream).
search_step(Open, Closed, Goal, Stream) :-
	%print('Searching..\n'),
	remove_from_queue(Next_record, Open, OpenTail),
	(bagof(Move, moves(Next_record, Open, Closed, Move), MoveList);MoveList = []),
	add_list_to_queue(MoveList, OpenTail, NewOpen),
	add_to_set(Next_record, Closed, NewClosed),
	search_step(NewOpen, NewClosed, Goal, Stream),!.

moves(State_record, Open, Closed, Next_record) :-
	state_record(State, _, State_record),
	arc(State, Next, _),
	state_record(Next, _, Test),
	not(member(Test, Open)),
	not(member(Test, Closed)),
	state_record(Next, State, Next_record).

print_solution(State_record, _, Stream) :-
	state_record(State, nil, State_record),
	write(Stream, State), nl(Stream).
print_solution(State_record, Closed, Stream) :-
	state_record(State, Parent, State_record),
	state_record(Parent, _, Parent_record),
	member(Parent_record, Closed),
	print_solution(Parent_record, Closed, Stream),
	write(Stream, State), nl(Stream).

print_visited([], _).
print_visited([H|Closed], Stream) :-
	print_visited(Closed, Stream),
	state_record(State, _, H),
	write(Stream, State), nl(Stream).