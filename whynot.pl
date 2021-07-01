:-dynamic node/4.
node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, residence(jon, sheffield), initial_fact,[]).

node(4, tier1(manchester), initial_fact, []).
node(5, tier1(sheffield), initial_fact, []).


rule(1,[residence(X, Y), residence(A, B), meetings_allowed(Y), meetings_allowed(B)],can_meet(X, A)).
rule(2,[tier1(X)], meetings_allowed(X)).


rule(3,[tier1(X)],tier2(X)).
rule(4,[tier2(X)],outdoor_meeting_allowed(X)).
rule(5,[residence(X, Y), residence(A, B), outdoor_meeting_allowed(Y), outdoor_meeting_allowed(B)], can_meet_outdoors(X, A)).
 

whynot(Q):-
    \+ deduce(Q,_DAG), !,
    write("user: Why not Q is true?"), 
    write("bot: Why do you think Q is true?"),
    write("user: Because rule F"),
    rule(F, A, Q),
    check(A, Notfact),
    write("bot:cannot deduce Notfact"). 


check([],[]).
check([H|T], [H|N]):-
    \+ deduce(H, _DAG),!, 
    check(T, N).
check([H|T], N):-
    deduce(H,_DAG),!,
    check(T,N).


deduce(Q, node(ID, Q, R , DAG)):-
   node(ID, Q, R , DAG).
deduce(Q, node(ID, Q, R , DAG)):-
   rule(ID_r, A, B),
   check_antecedants(A, NodeList),
   \+ node(_ID, B, _ID_r, _NodeList),!,
    countNumbers(Numbers),
    ID_n is Numbers +1,
    assert(node(ID_n,B,ID_r,NodeList)),
    deduce(Q, node(ID, Q, R, DAG)).
 
 
countNumbers(Numbers) :-
  aggregate_all(count, node(_,_,_,_), Numbers).
 
 
check_antecedants([],[]).
check_antecedants([H|T], [node(ID, H, R, DAG)|NodeList]):-
    node(ID, H, R , DAG),
    check_antecedants(T, NodeList).    


why_not(Q):-
    write("user: "), read(Q),nl,
    \+ deduce(Q,_DAG), !,
    write("bot: no "), nl,
    write("user: Why not "), write(Q), write(" is true?"), nl,
    write("bot: Why do you "), write(Q), write(" is true?"), nl,
    write("user: Because rule"), read(F),
    rule(F, A, Q),
    check(A, N),
    write("bot:cannot deduce "), write(N), nl,
    write("user: Why not "), read(C),
    write("bot: Why do you "), write(C), write(" is true?"),nl,
    write("user: "), read(D),
    \+ node(_N, C, initial_fact, _NL), !,
    write("bot: I was not told "), write(C), write(" is that a fact?"),nl,
    write("user: "),read(E), nl,
    write("bot: Added "), write(C), nl,
    assert(node(_N, C, initial_fact, _NL)),
    write("user: "),read(Q), nl,
    deduce(Q,_DAG), !,
    write("bot: yes "), nl.



 
explain(N):-
    node(N, _F, initial_fact, _NL), !,
    write("node "),
    write(N),
    write(" is an initial fact").
explain(N):-
    node(N, F, R, NL), !,
    rule(R, _A, F),
    write("node "),
    write(N),
    write(" is deduced using rule "),
    write(R),
    write(" from "),
    write(NL).



 