
:-dynamic node/4.
node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).

rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B)],can_meet_indoors(X, A)).
rule(2,[tier1(X)], indoor_meetings_allowed(X)).

chat:-
        print_welcome.

print_welcome:-
        print_prompt(me),
    	write('Mary and Karl can meet indoors is true'),
       	deduce(can_meet_indoors(mary,karl),Y), nl,
     	print_prompt(me),
    	write('Do you agree?'),nl,
    	print_prompt(you),
        read(S),
        print_prompt(me),
    	write(Y),nl,
    	print_prompt(you),
    	read(P),
    	explain(P),
     	flush_output.

print_prompt(me):-
        my_icon(X), write(X), write(': '), flush_output.
print_prompt(you):-
        user_icon(X), write(X), write(': '), flush_output.
my_icon('Computer ').
user_icon('User').



gen_reply(S, _):-
        is_yes(S), !,
    	write('Okay'),nl,
        flush_output.
is_yes(S):-
        agree_db(S).

agree_db([yes]).

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

check([],[]).
check([H|T], [H|N]):-
    \+ deduce(H, _DAG),!, 
    check(T, N).
check([H|T], N):-
    deduce(H,_DAG),!,
    check(T,N).


 
explain(F):-
    node(N, F, initial_fact, _NL), !,
    write("node "),
    write(F),
    write(" is an initial fact").
explain(F):-
    node(N, F, R, NL), !,
    rule(R, _A, F),
    write("node "),
    write(F),
    write(" is deduced using rule "),
    write(R),
    write(" from "),
    write(NL).



