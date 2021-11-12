
%% LOUISE:  both write_why_list and write_why_not_list feel a bit redundant to me.
%% The user has already said they want an explanation.
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


%% LOUISE:  This should not offer all nodes as a choice.  It should offer everything that is in
%% Y_user_computer (facts the user (should) think the computer knows) and which the user hasn't
%% asked before.
%% It should also allow the user to ask "why not" for everything in N_user_computer (facts the
%% user (should) think the computer doesn't know) and which the users hasn't asked before.
write_ask_list:-
    node(N, Fact, _, _),
    write(N), write('. '),  write(Fact), nl,
    fail.
write_ask_list.
