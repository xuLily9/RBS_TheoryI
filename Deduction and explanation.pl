:-dynamic node/4.
node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).
 
rule(1, [tier1(X)], indoor_meetings_allowed(X)).
rule(2,[residence(X,Y), indoor_meetings_allowed(Y),residence(A,B),indoor_meetings_allowed(B)],can_meet_indoors(X,A)).
 
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
 
 
is_fact(S):-
        nodes(S).
 
countNumbers(Numbers) :-
  aggregate_all(count, node(_,_,_,_), Numbers).
 
 
check_antecedants([],[]).
check_antecedants([H|T], [node(ID, H, R, DAG)|NodeList]):-
    node(ID, H, R , DAG),
    check_antecedants(T, NodeList).
 
explain(N):-
    node(N, F, initial_fact, NL), !,
    write("node "),
    write(N),
    write(" is an initial fact").
explain(N):-
    node(N, F, R, NL), !,
    rule(R, A, F),
    write("node "),
    write(N),
    write(" is deduced using rule "),
    write(R),
    write(" from "),
    write(NL).
 