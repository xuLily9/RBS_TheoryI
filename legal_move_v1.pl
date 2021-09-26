% :- [readin].
:-dynamic node/4, information/1.
node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).

question(1, "Why do you beleive it?").
question(2, "Why don't you beleive it?").
question(3, "I have my a difference reason.").
question(4, "Exit").

choice(1, "Yes, I agree").
choice(2, "No, I disagree").


answer(1, "Yes").
answer(2, "No, exit").

reason(1, "Because of the system's rule").
% reason(2, "Because of my rule").
reason(2, "Because of fact").

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
    print_prompt(bot),
    write("Because it is an initial fact"), nl.

why(F):-
    node(_N, F, R, NL), !,
    rule(R, _A, F),
    print_prompt(bot),
    write("Because "),
    write(F),
    write(" is deduced using rule "),
    write(R),
    write(" from "),
    write(NL), nl.

why(F):-
    \+ node(_N, F, initial_fact, _NL), !,
    \+ deduce(F,node(_ID, F, _R, _DAG)), !,
    print_prompt(bot),
   % write(F), write(' is false.'),nl,
    write("Because "),
    write(F),
    write(" is not an initial fact and it cannot be deduced"), nl.

% leagel move 8. 
why_rule(R):-
    rule(R, A, _F),
    check(A, N),
    print_prompt(bot),
    write("In the rule "), write(R), write(N), write(" cannot be deduced by rule "), write(R), nl.


why_fact(Fact):-
     \+ node(_N, Fact, initial_fact, []), !,
    write("bot: I was not told "), write(Fact), write(" is that a fact?"),nl,
    write("user: "), read_answer(Nanswer) , nl,
    Nanswer =:= 1 ->
    write("bot: Added "), write(Fact), nl,
    countNumbers(Numbers),
    N is Numbers +1,
    assert(node(N, Fact, initial_fact, [])), nl.


check([],[]).
check([H|T], [H|N]):-
    \+ deduce(H, _DAG),!, 
    check(T, N).
check([H|T], N):-
    deduce(H,_DAG),!,
    check(T,N).


read_question(Number) :-
    repeat,
    print_prompt(bot),
    write('Please select a question or exit:'), nl,
    write_question_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (   question(Number, QName)
    ->  write('You selected question: '), write(Number), write('. '), write(QName),nl, !
       % write('Enter the fact related to this question: '), read(Fact),nl, !
    ;   write('Not a valid choice, try again...'), nl, fail
    ).

read_choice(NChoice) :-
    repeat,
    print_prompt(bot),
    write('Do you agree with me?'), nl,
    write_choice_list,
    print_prompt(user),
    prompt(_, ''),
    read(NChoice),
    (   choice(NChoice,Choice)
       -> write(NChoice), write('. '), write(Choice),nl, !
        ;   write('Not a valid choice, try again...'), nl, fail
        ).

% ask_question :-
 %   print_prompt(bot),
  %  write('Do you have any questions?'),nl,
   % read_answer(Nanswer).


read_answer(Nanswer) :-
    write_answer_list,
    print_prompt(user),
    prompt(_, ''),
    read(Nanswer),
    (   Nanswer =:= 2
        -> print_prompt(bot), write('Bye'),nl,!, halt
        ;  Nanswer =:= 1
        -> print_prompt(bot), write('Okay, let us move on.'),nl,!
        ;write('Not a valid choice, try again...'), nl
    ).


read_reason(Number) :-
    print_prompt(bot),
    write('Please select your reason: '), nl,
    write_reason_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (   Number =:= 1
    ->  print_prompt(user), write('Enter a rule number: '), read(Rule), why_rule(Rule), nl, !
    ;  Number  =:= 2
    -> print_prompt(user), write('Enter a fact: '), read(Fact), why_fact(Fact),nl, !
    ; write('Not a valid choice, try again...'), nl, fail
    ).



write_question_list :-
    question(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_question_list.

write_choice_list :-
    choice(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_choice_list.

write_answer_list :-
    answer(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_answer_list.

write_reason_list :-
    reason(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_reason_list.


write_node_list :-
    write('FACT:'),nl,
    node(N, Fact, initial_fact, []),
    write(N), write('. '), write(Fact), write(' is an initial fact'),nl,
    fail.
write_node_list.


write_rule_list :-
    write('RULE:'),nl,
    rule(N, Antecedants, C),
    write(N), write('. If '), write(Antecedants), write(' are satisfied then '), write(C), write(' is true'), nl,
    fail.
write_rule_list.



chat:-
	write_node_list,!,
        write_rule_list,!,
        print_welcome,
        conversations.

print_welcome:-
      %  write('Please enter the fact that you want to check'),nl,
      %  print_prompt(user),
        print_prompt(bot),
        read(F),nl,
        (deduce(F,node(_ID, F, _R, _DAG))
            -> print_prompt(bot),write(F), write(' is true.'), nl, ! ;
           print_prompt(bot),write(F), write(' is false.'), nl, flush_output ),
        read_choice(_NChoice).

conversations:-
        repeat,
        print_prompt(bot),
        write('Do you have any questions?'),nl,
        read_answer(_Nanswer),nl,
        read_question(Number), nl,
        print_prompt(bot),
        gen_reply(Number),
        (Number = 4, !; fail
        ).
 

print_prompt(bot):-
        my_icon(X), write(X), write(': '), flush_output.
print_prompt(user):-
        user_icon(X), write(X), write(': '), flush_output.
my_icon('Computer ').
user_icon('User').


gen_reply(1):-
        write('Please enter the fact related to this question: '), nl,
        print_prompt(user),
        read(Fact),nl, !,
       % print_prompt(bot),
        why(Fact),nl.

gen_reply(2):-
        write('Please enter the fact related to this question: '), nl,
        print_prompt(user),
        read(Fact),nl, !,
       % print_prompt(bot),
        why(Fact),nl.


gen_reply(3):-
        read_reason(_Fact),nl .

gen_reply(4):-
        write("Bye"),nl,
        flush_output.


subset([], _).
subset([H|T], L2):-
        member(H, L2),
        subset(T, L2).
