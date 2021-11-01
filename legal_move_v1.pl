:- [deduce_backwards].
:-dynamic node/4, user_fact/2, not_believe/1, believe/1, user_rule/3, different/1.
node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).

fact(1, "Yes, it is a initial fact").
fact(2, "No, I need some explanations about this fact").

choice(1, "Yes, I am satisfied. Exit.").
choice(2, "No, I need more explanations.").

reason(1, "Because of a rule.").
reason(2, "It's an initial fact.").

answer(1, "An antecedant").
answer(2, "A conclusion").
answer(3, "Exit").

rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B)],can_meet_indoors(X, A)).
rule(2,[tier1(X)], indoor_meetings_allowed(X)).

% start the conversations

chat:-
    write_node_list,!,
    write_rule_list,!,
    print_welcome,
    conversations.


print_welcome:-
    write("Computer: What do you want to know?"), nl,
    print_prompt(user),
    read(F),
    (
        deduce(F,node(_ID, F, _R, _DAG))
        -> print_prompt(bot),write(F), write(' is true.'), nl, ! ,
        read_agree, !,
        why_question(F)
    ;                                 % legal move 4: some t ∈ Gi ∪ Nij the player may ask whynot(t)
       print_prompt(bot),write(F), write(' is false.'), nl,!,
       read_agree, !,
       whynot_question(F),!
       ).

conversations:-
    repeat,
    read_agree,  
    write("Computer: What do you want to know?"), nl,
    read_answer(_N),
    different(_),!,halt.
 
print_prompt(bot):-
        my_icon(X), write(X), write(': '), flush_output.
print_prompt(user):-
        user_icon(X), write(X), write(': '), flush_output.
my_icon('Computer ').
user_icon('User').




% the deduction of a fact
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




% why question section 
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



why(F):-                                              % legal move 1: If s = why(t) and t ∈ Fi then initial(t)
    node(_N, F, initial_fact, _NL), !,
    print_prompt(bot),                              % legal move 6:
    write("Because it is an initial fact"), nl,
     \+ user_fact(F, initial_fact),
    write("Computer: I have identify the disagreement. "), write(F),write(" is a system's initial fact, not a user initial fact"),nl, 
    assert(different(F)),!, halt.
  
why(F):-                                              % legal move 1: If s = why(t) and t ∈ Fi then initial(t)
    user_fact(F, initial_fact), !,
    print_prompt(bot),
    write("Because it is a user initial fact"), nl.

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




% why not question section                         
whynot_question(Fact) :- % If the conlusion is false
    repeat,
    print_prompt(bot),
    write('Please select a question or exit:'), nl, !,
    write_whynot_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (   Number =:= 1
    ->  write("User: Why don't you beleive "), write(Fact), write("?"), nl, !,        
        assert(believe(Fact)), !, 
        whynot(Fact), !
    ;   Number =:= 2
    ->  print_prompt(bot), write('Bye'),nl, retract(user_fact(_X, _Y)), !, halt
    ;   write('Not a valid choice, try again...'), nl, fail
    ).


whynot(F):-
    repeat,
    write("Computer: Why do you believe "), write(F), write(" ?"),nl,    % legal move 3: If s = whynot(t) then answer why(t).
    print_prompt(bot),
    write('Select your reason: '), nl,
    write_reason_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (  Number =:= 1
    -> why_rule(F), nl, !
    ;   Number  =:= 2
    -> write("User: It's an initial fact."),nl,                   % legal move 6
    \+ node(_N, F, initial_fact, []), !,
    \+ user_fact(F,initial_fact), !,
    assert(user_fact(F,initial_fact)), !,
    write("Computer: I have identify the disagreement. "), write(F),write(" is a user's initial fact, not a system's initial fact"),nl, 
    assert(different(F)),!, halt
    ; write('Not a valid choice, try again...'), nl, fail
    ).



why_rule(F):-
    write("User: Please enter rule number: "), 
    read(R),
    rule(R, A, F),                                 % legal move 8: For some rule label, l ∈ Y Rij then the player may state different rule(l, j, i).
    check(A, N),
    print_prompt(bot),
    write("I cannot deduce "),  write(N), nl,
    write("Computer: I have identified the disagreement. We have a different rule."),nl,
    assert(different(F)),!,halt.

check([],[]).
check([H|T], [H|N]):-
    \+ deduce(H, _DAG),!, 
    check(T, N).
check([H|T], N):-
    deduce(H,_DAG),!,
    check(T,N).


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


read_agree :-
    write("Computer: Are you satisfied with the results? or you require additional explanations"),nl,
    write_choice_list,
    print_prompt(user),
    prompt(_, ''),
    read(Nanswer),
    (   Nanswer =:= 1
    ->  print_prompt(bot), write('Bye'),nl,!, halt
    ;   Nanswer =:= 2
    ->  print_prompt(bot), write('Okay, let us move on.'),nl,!
    ;   write('Not a valid choice, try again...'), nl
    ).


read_answer(Nanswer) :-
    write_answer_list,
    print_prompt(user),
    prompt(_, ''),
    read(Nanswer),
    (   Nanswer =:= 3
    ->  print_prompt(bot), write('Bye'),nl,!, halt
    ;    Nanswer =:= 2
    ->  print_prompt(bot), write("Please enter the conclusion: "),nl,!
     ;   Nanswer =:= 1
    ->  print_prompt(bot), write("Please enter the antecedant: "),nl,!
    ;   write('Not a valid choice, try again...'), nl
    ),
    print_prompt(user),
    read(F),
    (
        deduce(F,node(_ID, F, _R, _DAG))
        -> print_prompt(bot),write(F), write(' is true.'), nl, ! ,
        read_agree, !,
        why_question(F),!
    ;                                 % legal move 4: some t ∈ Gi ∪ Nij the player may ask whynot(t)
       print_prompt(bot),write(F), write(' is false.'), nl,!,
       read_agree, !,
       whynot_question(F),!
       ).


write_why_list :-
    write(1), write('. '), write("Why do you beleive?"),nl,
    write(2), write('. '), write("Exit"), nl.


write_whynot_list :-
    write(1), write('. '), write("Why don't you beleive?"),nl,
    write(2), write('. '), write("Exit"), nl.


write_choice_list :-
    choice(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_choice_list.

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


write_answer_list :-
    answer(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_answer_list.



% For a non-empty list: flatten the head and flatten the tail and
flat_list([],[]).
flat_list([Head|InTail], [Head|OutTail]) :-
    Head \= [],
    Head \= [_|_],
    flat_list(InTail,OutTail).
flat_list([Head|InTail],Out):-
    flat_list(Head,FlatHead),
    flat_list(InTail,OutTail),
    append(FlatHead,OutTail,Out).


% flat_list = [item for sublist in t for item in sublist]
% flat_list = []
% for sublist in t:
%    for item in sublist:
%        flat_list.append(item)

flat_list([],[]).

flat_list([Head|InTail],[Head|N]):-
    \+ is_list(Head),!,
    flat_list(InTail,N).

    
len([],0).
len([_|T],L):-
    len(T,LT),
    L is LT+1.
