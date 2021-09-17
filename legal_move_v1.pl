% :- [readin].
:-dynamic node/4, information/1.
node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).

question(1, 'Why?').
question(2, 'Why not?').
question(3, 'Do you agree?').

rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B)],can_meet_indoors(X, A)).
rule(2,[tier1(X)], indoor_meetings_allowed(X)).


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


why(F):-
    node(_N, F, initial_fact, _NL), !,
    write("It is an initial fact").
why(F):-
    node(_N, F, R, NL), !,
    rule(R, _A, F),
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
    print_prompt(user_icon),
    read(Number),
    (   question(Number, QName)
    ->  write('You selected question: '), write(Number), write('. '),write(QName), nl, !
    ;   write('Not a valid choice, try again...'), nl, fail
    ).

write_question_list :-
    question(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_question_list.


write_node_list :-
    node(N, Fact, initial_fact, []),
    write(N), write('. '), write(Fact), write(' is an initial fact'),nl,
    fail.
write_node_list.


write_rule_list :-
    rule(N, Antecedants, C),
    write(N), write('. If '), write(Antecedants), write(' are satisfied then '), write(C), write(' is true'), nl,
    fail.
write_rule_list.



chat:-
	write_node_list,!,
        print_welcome.

print_welcome:-
        print_prompt(bot),
        read(F),nl,
        deduce(F,node(ID, F, R, DAG)),
        write(F), write(' is true.'),nl,
        read_question(Q),
        print_prompt(bot),
        why(F),
        flush_output.

conversations:-
        read_question(Q),
        print_prompt(bot),
        why(F).

 

print_prompt(bot):-
        my_icon(X), write(X), write(': '), flush_output.
print_prompt(user):-
        user_icon(X), write(X), write(': '), flush_output.
my_icon('Computer ').
user_icon('User').


	
gen_reply(Q, R):-
        is_question(Q),
        assert(information(Q,R)),
        why(Q).

gen_reply(S, _):-
        is_quit(S), !,
        write("Bye"),nl,
        flush_output.

is_question(S):-
        member('Why it is true', S).

is_quit(S):-
        subset([bye], S).


