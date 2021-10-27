:-dynamic node/4, user_fact/2, not_believe/1, believe/1, user_rule/3, different/1.

deduce_backwards(Q, node(ID, Q, R , DAG)):-
   node(ID, Q, R , DAG).
deduce_backwards(Q, node(ID, Q, ID_r , NodeList)):-
   rule(ID_r, A, Q),
   \+ node(_ID, Q, _ID_r, _NodeList),
   check_antecedants(A, NodeList), !,
   countNumbers(Numbers),
   ID is Numbers +1,
   assert(node(ID,Q,ID_r,NodeList)).
 
countNumbers(Numbers) :-
  aggregate_all(count, node(_,_,_,_), Numbers).

 
check_antecedants([],[]).
check_antecedants([H|T], [node(ID, H, R, DAG)|NodeList]):-
    deduce_backwards(H, node(ID, H, R, DAG)),
    check_antecedants(T, NodeList).
check_antecedants([not(H)|T], [node(ID_n,not(H),unprovable,[])|NodeList]):-
    \+ deduce_backwards(H, _DAG), !,
    countNumbers(Numbers),
    ID_n is Numbers +1,
    assert(node(ID_n,not(H),unprovable,[])),
    check_antecedants(T, NodeList).



