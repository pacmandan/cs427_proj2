/**
  * Heuristic-First (Best-First) Search strategy definition
  */

% Priority Queue functions
empty_sort_queue([]).
member_sort_queue(E, S) :- member(E, S).
insert_sort_queue(State, [], [State]).  
insert_sort_queue(State, [H | T], [State, H | T]) :-
	precedes(State, H).
insert_sort_queue(State, [H|T], [H | T_new]) :-
	insert_sort_queue(State, T, T_new).
insert_list_sort_queue([], Q, Q).
insert_list_sort_queue([H|T], Queue, New_Queue) :-
	insert_sort_queue(H, Queue, TempQueue),
	insert_list_sort_queue(T, TempQueue, New_Queue).
remove_sort_queue(First, [First|Rest], Rest).

% Set functions
empty_set([]).
add_to_set(X, S, S) :- member(X, S), !.
add_to_set(X, S, [X|S]).

% Predicate used by the priority queue.
% Determines state 1 is better than state 2 by comparing their heuristics.
precedes(State_record1, State_record2) :-
	state_record(State1, Parent1, State_record1),
	state_record(State2, Parent2, State_record2),
	heuristic(H1, State1),
	heuristic(H2, State2),
	arc(State1, Parent1, Cost1),
	arc(State2, Parent2, Cost2),
	heuristic_compare(H1 + Cost1, H2 + Cost2).

% State records. Used to keep track of where we've been
% by keeping each state in a pair with its parent.
state_record(State, Parent, [State, Parent]).

% Starts the search.
begin(Start, Goal, Filename) :-
	empty_sort_queue(EmptyOpen),
	empty_set(Closed),
	state_record(Start, nil, State),
	insert_sort_queue(State, EmptyOpen, Open),
	open(Filename, append, Stream),
	search_step(Open, Closed, Goal, Stream),
	write(Stream, '--------------'), nl(Stream),
	close(Stream).

% Search step. Has three predicates:
% Nothing left in open - search has failed.
search_step(Open, _, _, Stream) :-
	empty_sort_queue(Open),
	write(Stream, 'No solution found.').
% Goal state matches current state. Search has succeeded!
search_step(Open, Closed, Goal, Stream) :-
	remove_sort_queue(Next_record, Open, _),
	state_record(State, _, Next_record),
	Goal = State,
	write(Stream, 'States Visited:'), nl(Stream),
	print_visited(Closed, Stream), nl(Stream),
	write(Stream, 'Solution:'), nl(Stream),
	print_solution(Next_record, Closed, Stream).
% Otherwise, open all states that can be moved to from this state, and put them
% into the priority queue. Recurse.
search_step(Open, Closed, Goal, Stream) :-
	remove_sort_queue(Next_record, Open, OpenTail),
	(bagof(Move, moves(Next_record, Open, Closed, Move), MoveList);MoveList=[]),
	insert_list_sort_queue(MoveList, OpenTail, NewOpen),
	add_to_set(Next_record, Closed, NewClosed),
	search_step(NewOpen, NewClosed, Goal, Stream), !.

% Unifies if Next_record can be obtained by moving to it from
% State_record AND Next_record isn't in Open or Closed.
% Unifies with the arc/2 predicate.
moves(State_record, Open, Closed, Next_record) :-
	state_record(State, _, State_record),
	arc(State, Next, _),
	state_record(Next, _, Test),
	not(member(Test, Open)),
	not(member(Test, Closed)),
	state_record(Next, State, Next_record).

% Prints out the solution to the screen.
% May move these predicates to solver.pl, since all
% search strategies might use this.
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