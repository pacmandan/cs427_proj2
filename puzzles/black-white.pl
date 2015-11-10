/**
  * Black-White problem definition
  */

%State definition: [A, B, C, D, E, F, G]
/* 
  W: Number of white tiles to the left of Black tiles
  B: Position of the blank tile
 */

start([b,b,b,blank,w,w,w]).
goal([w,w,w,blank,b,b,b]).
goal([w,blank,w,w,b,b,b]).
goal([blank,w,w,w,b,b,b]).
goal([w,w,blank,w,b,b,b]).
goal([w,w,w,b,blank,b,b]).
goal([w,w,w,b,b,blank,b]).
goal([w,w,w,b,b,b,blank]). 


/* [blank, A, B, C, D, E, F] */

arc([blank, A, B, C, D, E, F], Child, 1) :-
    Child = [A, blank, B, C, D, E, F].

arc([blank, A, B, C, D, E, F], Child, 1) :-
    Child = [B, A, blank, C, D, E, F].

arc([blank, A, B, C, D, E, F], Child, 2) :-
    Child = [C, A, B, blank, D, E, F].

/* [A, blank, B, C, D, E, F] */

arc([A, blank, B, C, D, E, F], Child, 1) :-
    Child = [blank, A, B, C, D, E, F].

arc([A, blank, B, C, D, E, F], Child, 1) :-
    Child = [A, B, blank, C, D, E, F].

arc([A, blank, B, C, D, E, F], Child, 1) :-
    Child = [A, C, B, blank, D, E, F].

arc([A, blank, B, C, D, E, F], Child, 2) :-
    Child = [A, D, B, C, blank, E, F].

/* [A, B, blank, C, D, E, F] */

arc([A, B, blank, C, D, E, F], Child, 1) :-
    Child = [A, blank, B, C, D, E, F].

arc([A, B, blank, C, D, E, F], Child, 1) :-
    Child = [A, B, C, blank, D, E, F].

arc([A, B, blank, C, D, E, F], Child, 1) :-
    Child = [blank, B, A, C, D, E, F].

arc([A, B, blank, C, D, E, F], Child, 1) :-
    Child = [A, B, D, C, blank, E, F].

arc([A, B, blank, C, D, E, F], Child, 1) :-
    Child = [A, B, E, C, D, blank, F].

/* [A, B, C, blank, D, E, F] */

arc([A, B, C, blank, D, E, F], Child, 1) :-
    Child = [A, B, blank, C, D, E, F].

arc([A, B, C, blank, D, E, F], Child, 1) :-
    Child = [A, B, C, D, blank, E, F].

arc([A, B, C, blank, D, E, F], Child, 1) :-
    Child = [A, blank, C, B, D, E, F].

arc([A, B, C, blank, D, E, F], Child, 1) :-
    Child = [A, B, C, E, D, blank, F].

arc([A, B, C, blank, D, E, F], Child, 2) :-
    Child = [blank, B, C, A, D, E, F].

arc([A, B, C, blank, D, E, F], Child, 2) :-
    Child = [A, B, C, F, D, E, blank].

/* [A, B, C, D, blank, E, F] */

arc([A, B, C, D, blank, E, F], Child, 1) :-
    Child = [A, B, C, blank, D, E, F].

arc([A, B, C, D, blank, E, F], Child, 1) :-
    Child = [A, B, C, D, E, blank, F].

arc([A, B, C, D, blank, E, F], Child, 1) :-
    Child = [A, B, blank, D, C, E, F].

arc([A, B, C, D, blank, E, F], Child, 1) :-
    Child = [A, B, C, D, F, E, blank].

arc([A, B, C, D, blank, E, F], Child, 2) :-
    Child = [A, blank, C, D, B, E, F].

/* [A, B, C, D, E, blank, F] */

arc([A, B, C, D, E, blank, F], Child, 1) :-
    Child = [A, B, C, D, blank, E, F].

arc([A, B, C, D, E, blank, F], Child, 1) :-
    Child = [A, B, C, D, E, F, blank].

arc([A, B, C, D, E, blank, F], Child, 1) :-
    Child = [A, B, C, blank, E, D, F].

arc([A, B, C, D, E, blank, F], Child, 2) :-
    Child = [A, B, blank, D, E, C, F].

/* [A, B, C, D, E, F, blank] */

arc([A, B, C, D, E, F, blank], Child, 1) :-
    Child = [A, B, C, D, E, blank, F].

arc([A, B, C, D, E, F, blank], Child, 1) :-
    Child = [A, B, C, D, blank, F, E].

arc([A, B, C, D, E, F, blank], Child, 2) :-
    Child = [A, B, C, blank, E, F, D].
