% :- [readin].
:-dynamic node/4, user_fact/2, not_believe/1, believe/1, user_rule/3.
node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).

question(1, "Why do you beleive?").
question(2, "Why don't you beleive?").
question(3, "Exit").

fact(1, "Yes, it is a initial fact").
fact(2, "No, I need some explanations about this fact").


choice(1, "Yes, I agree").
choice(2, "No, I disagree").


answer(1, "Yes").
answer(2, "No, exit").

reason(1, "Because of a rule ").
reason(2, "Because of a fact ").

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
    (   node(ID, H, R , DAG)
    -> assert(believe(H)), !                    % statement 2. Ifs=l:a→tandl∈Ri
    ;
       assert(not_believe(H)),!
    ),
    check_antecedants(T, NodeList).



why(F):-                                              % legal move 1: If s = why(t) and t ∈ Fi then initial(t)
    node(_N, F, initial_fact, _NL), !,
    print_prompt(bot),
    write("Because it is an initial fact"), nl.

why(F):-                                              % legal move 1: If s = why(t) and t ∈ Fi then initial(t)
    user_fact(F, initial_fact), !,
    print_prompt(bot),
    write("Because it is an initial fact"), nl.

why(F):-                                             % legal move 2: Ifs=why(t) and t∈Fi thenforsomenoden=⟨t,l⟩∈Gi 
    node(_N, F, R, NL), !,                           % A→t where A are the terms for n parent nodes.
    rule(R, _A, F),
    print_prompt(bot),
    write("Because "),
    write(F),
    write(" is deduced using rule "),
    write(R),
    write(" from "),
    write(NL), nl.


whynot(F):-
    write("Computer: Why do you believe "), write(F), write(" ?"),nl,    % legal move 3: If s = whynot(t) then answer why(t).
    read_reason(F).


read_reason(F) :-
   print_prompt(bot),
   write('Select your reason: '), nl,
    write_reason_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (  Number =:= 1
    -> why_rule(F), nl, !
    ;   Number  =:= 2
    -> write("user: Please enter a fact:"), 
        read(Fact),
       (
          user_fact(Fact, initial_fact), !,          % legal move 6: If s ̸= why(t) and s ̸= whynot(t) For some t ∈ Fij where t ̸∈ Fi the player may state different fact(t,j,i). Player i has identified that t was an initial fact for Player j but not for Player i.
          \+ node(_, Fact, initial_fact, []),!
            ->  write("Computer: We have different fact. "), write(Fact),write(" is a user's initial fact, but not a system's initial fact"),nl, !, halt
        ;  \+ user_fact(Fact, initial_fact), !,
            node(_, Fact, initial_fact, []),!
            ->  write("Computer: We have different fact. "), write(Fact),write(" is a system's initial fact, but not a user initial fact"),nl, !, halt
        )
    ; write('Not a valid choice, try again...'), nl, fail
    ).



why_rule(F):-
    write("User: Please enter rule number: "), 
    read(R),
    rule(R, A, F),                                 % legal move 8: For some rule label, l ∈ Y Rij then the player may state different rule(l, j, i).
    check(A, N),
    print_prompt(bot),
    write("I cannot deduce "),  write(N), nl,
    write("Computer: we have a different rule"),nl, halt.

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


why_question(Fact) :-  % If the conclusion is true
    repeat,
    print_prompt(bot),
    write('Please select a question or exit:'), nl, !,
    write_why_list, 
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (   Number =:= 1
    ->  write('You selected question: '), write("Why do you beleive "),write(Fact), write("?"), nl, !,
        assert(not_believe(Fact)), !,
        why(Fact), ! 
    ;   Number =:= 2
    ->  print_prompt(bot), write('Bye'),nl, retract(user_fact(_X, _Y)), !, halt
    ;   write('Not a valid choice, try again...'), nl, fail
    ).


                            
whynot_question(Fact) :- % If the conlusion is false
    repeat,
    print_prompt(bot),
    write('Please select a question or exit:'), nl, !,
    write_whynot_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (   Number =:= 1
    ->  write('You selected question: '), write("Why don't you beleive "), write(Fact), write("?"), nl, !,        
        assert(believe(Fact)), !, 
        whynot(Fact), !
    ;   Number =:= 2
    ->  print_prompt(bot), write('Bye'),nl, retract(user_fact(_X, _Y)), !, halt
    ;   write('Not a valid choice, try again...'), nl, fail
    ).


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
    ;   write('Not a valid choice, try again...'), nl, fail
    ).



read_fact(F) :-
    write_fact_list,
    print_prompt(user),
    prompt(_, ''),
    read(NFact),
    (   NFact =:= 1
    ->  write("Computer: I add "), write(F), write(" to user initial facts."),nl,
        assert(user_fact(F,initial_fact)), !
     ;   NFact =:= 2
    -> 
        whynot_question(F)
    ;   write('Not a valid choice, try again...'), nl
    ).


read_answer(Nanswer) :-
    write_answer_list,
    print_prompt(user),
    prompt(_, ''),
    read(Nanswer),
    (   Nanswer =:= 2
    ->  print_prompt(bot), write('Bye'),nl,!, halt
    ;   Nanswer =:= 1
    ->  print_prompt(bot), write('Okay, let us move on.'),nl,!
    ;   write('Not a valid choice, try again...'), nl
    ).





write_why_list :-
    write(1), write('. '), write("Why do you beleive?"),nl,
    write(2), write('. '), write("Exit"), nl.


write_whynot_list :-
    write(1), write('. '), write("Why don't you beleive?"),nl,
    write(2), write('. '), write("Exit"), nl.

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


write_fact_list :-
    fact(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_fact_list.


initial(F):-
      \+ node(_N, F, initial_fact, _NL), !,
      \+ user_fact(F, initial_fact), !,
      print_prompt(bot),
      write("I was not told "), write(F),write("."), write(" Is this an initial fact?"),nl,
      read_fact(F).                        %  state updates1: If s = initial(t) then Pi adds t to Yij and Fij


initial(F):-
        (deduce(F,node(_ID, F, _R, _DAG))
            -> print_prompt(bot),write(F), write(' is true.'), nl, ! ,  
            why_question(_Number),!;                                % legal move 5: some t ∈ Yij\Gi the player may ask why(t).
           print_prompt(bot),write(F), write(' is false.'), nl,!,
           whynot_question(F),!).

chat:-
	write_node_list,!,
        write_rule_list,!,
        print_welcome,
        conversations.

print_welcome:-
        print_prompt(user),
        read(F),nl,
        (deduce(F,node(_ID, F, _R, _DAG))
            -> print_prompt(bot),write(F), write(' is true.'), nl, ! ,
            why_question(_Number),!;                                 % legal move 4: some t ∈ Gi ∪ Nij the player may ask whynot(t)
           print_prompt(bot),write(F), write(' is false.'), nl,!,
           initial(F),!).

conversations:-
        repeat,
        print_prompt(bot),
        write('Do you have any questions?'),nl,
        read_answer(_Nanswer),nl,
        read_question(Number),
        gen_reply(Number),
        (Number = 3, !; fail).
 

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
        why(Fact),nl.

gen_reply(2):-
        write('Please enter the fact related to this question: '), nl,
        print_prompt(user),
        read(Fact),nl, !,
        why(Fact),nl.


gen_reply(3):-
        write("Bye"),nl,
        flush_output.


