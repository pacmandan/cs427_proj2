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

begin(Start, Goal) :-
	%print('Begin!\n'),
	empty_queue(Empty_Open),
	empty_set(Closed),
	state_record(Start, nil, State),
	add_to_queue(State, Empty_Open, Open),
	search_step(Open, Closed, Goal).

search_step(Open, _, _) :- empty_queue(Open), print('Empty Queue!'), nl.
search_step(Open, Closed, Goal) :-
	remove_from_queue(Next_record, Open, _),
	state_record(State, _, Next_record),
	Goal = State,
	write('States Visited:'), nl,
	print_visited(Closed), nl,
	write('Solution:'), nl,
	print_solution(Next_record, Closed).
search_step(Open, Closed, Goal) :-
	%print('Searching..\n'),
	remove_from_queue(Next_record, Open, OpenTail),
	(bagof(Move, moves(Next_record, Open, Closed, Move), MoveList);MoveList = []),
	add_list_to_queue(MoveList, OpenTail, NewOpen),
	add_to_set(Next_record, Closed, NewClosed),
	search_step(NewOpen, NewClosed, Goal),!.

moves(State_record, Open, Closed, Next_record) :-
	state_record(State, _, State_record),
	arc(State, Next, _),
	state_record(Next, _, Test),
	not(member(Test, Open)),
	not(member(Test, Closed)),
	state_record(Next, State, Next_record).

print_solution(State_record, _) :-
	state_record(State, nil, State_record),
	write(State), nl.
print_solution(State_record, Closed) :-
	state_record(State, Parent, State_record),
	state_record(Parent, _, Parent_record),
	member(Parent_record, Closed),
	print_solution(Parent_record, Closed),
	write(State), nl.

print_visited([]).
print_visited([H|Closed]) :-
	print_visited(Closed),
	state_record(State, _, H),
	write(State), nl.