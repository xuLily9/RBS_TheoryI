:-dynamic node/4.
node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).

question(1, 'Why?').
question(2, 'Why not?').
question(3, 'Do you agree?').

rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B)],can_meet_indoors(X, A)).
rule(2,[tier1(X)], indoor_meetings_allowed(X)).


deduce(Q, node(ID, Q, R, DAG)):-
   node(ID, Q, R ,DAG).
deduce(Q, node(ID, Q, R, DAG)):-
   rule(ID_r, A, B),
   check_antecedants(A, NodeList),
   countNumbers(Numbers),
    ID_n is Numbers +1,
   \+ node(ID_n, B, ID_r, _NodeList),!,
    assert(node(ID_n,B,ID_r,NodeList)),
    deduce(Q, node(ID, Q, R, DAG)).

 
countNumbers(Numbers) :-
  aggregate(count, Module, ID^node(ID, Module,_,_), Numbers).

 
check_antecedants([],[]).
check_antecedants([H|T], [node(ID, H, R, DAG)|NodeList]):-
    node(ID, H, R , DAG),
    check_antecedants(T, NodeList).


why(F):-
    node(_N, F, initial_fact, _NL), !,
    write("It is an initial fact").
why(F):-
    node(_N, F, R, NL), !,
    rule(R, A, F),
    write("Fact "),
    write(F),
    write(" is deduced using rule "),
    write(R),
    write(" from "),
    write(NL).


% Legal move 4. 
whynot(F):-
	deduce(F,_DAG), !,
	node(_N, F, _, _), !,
	write("user: Why not "), 
	write(F),
	write(" ?"),nl,
	why(F).

% legal move 5. 
whynot(F):-
	deduce(F,_DAG), !,
	why(F).

% legal move 6. 
whynot(F):-
	\+ node(_N, F, initial_fact, _NL), !,
	write(F),
	write(" is not an initial fact").

% leagal move 7. 
whynot(F):-
	node(_N, F, initial_fact, _NL), !,
	write(F),
	write(" is an initial fact").

% leagel move 8. 
whynot(F):-
	rule(R, A, F),
    check(A, N),
	write(N), write(" cannot be deduced."), nl.


check([],[]).
check([H|T], [H|N]):-
    \+ deduce(H, _DAG),!, 
    check(T, N).
check([H|T], N):-
    deduce(H,_DAG),!,
    check(T,N).



read_question(QName) :-
    repeat,
    write('Please select a question:'), nl,
    write_question_list,
    read(Number),
    (   question(Number, QName)
    ->  write('You selected: '), write(QName), nl, !
    ;   write('Not a valid choice, try again...'), nl, fail
    ).

write_question_list :-
    question(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_question_list.














