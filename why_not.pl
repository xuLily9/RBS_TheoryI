:-dynamic node/4.
node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).


node(4, name(mary), initial_fact, []).
node(5, inuk(manchester), initial_fact, []).
rule(3, [name(X), residence(X, Y), inuk(Y)], inuk(X)).

rule(4,[tier1(X)],shops_open(X)).
rule(5,[residence(X, Y), shops_open(Y)], can_go_to_shops(X)).

 
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
 
 
countNumbers(Numbers) :-
  aggregate_all(count, node(_,_,_,_), Numbers).
 
 
check_antecedants([],[]).
check_antecedants([H|T], [node(ID, H, R, DAG)|NodeList]):-
    node(ID, H, R , DAG),
    check_antecedants(T, NodeList).
 
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


why(A):-
    deduce(A,DAG),
    write("user: Why "), write(A), write(" is true?"), nl,
    node(N, A, R, NL),
    write("Bot: Because "),explain(N); 
    write("bots: I don't know this").


determine_whynot(Q):-
    node(ID, Q, R , DAG).


determine_whynot(Q):-
    rule(ID_r, A, Q),
    check_antecedants2(A, Notfact).


check_antecedants2([],[]).
check_antecedants2([H|T], [node(ID, H, R, DAG)| Notfact]):-
    \+ node(ID, H, R , DAG),!,
    determine_whynot(H),
    check_antecedants2(T, Notfact).
 


whynot:-
    write("user: Why not"), write(Q), write(" is true?"), nl,
    write("bot: Why do you "), write(Q), write(" is true?"), nl,
    write("user: Because "),
    read(F).





# chat:-
#         conversations.



# print_report:-
#         node(ID, H, R , DAG), write('node('),write(ID), write(', '), write(H),write(', '),write(R),write(', '),write(DAG),write(') '),nl.
# print_report.


# print_prompt(me):-
#         my_icon(X), write(X), write(': '), flush_output.
# print_prompt(you):-
#         user_icon(X), write(X), write(': '), flush_output.
# my_icon('Bot ').
# user_icon('User').



# why_not(F):-
#     \+ node(N, F, R, NL),!,
#     write("user: why "), 
#     read(F),
#     write(" is not true?"),
#     write("Bots: why do you think it is true?"),
#     write("user: Because "),
#     read(Q),
#     node(N, Q, R, NL),
#     write("Bots:You are right");
#     \+ node(N, Q, R, NL),!,
#     write("Bots:I am sorry the antecedants can not be satisfied").
 