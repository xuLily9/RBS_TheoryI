
%% LOUISE:  both write_why_list and write_why_not_list feel a bit redundant to me.
%% The user has already said they want an explanation.


%% Pretty print the facts with nature language

 
print_fact(Fact):-
    fact_description(Fact).

write_fact_list :-
    write("USER FACT: "),nl,
    user_fact(_N, Fact, initial_fact, []),
    print_fact(Fact),nl,
    fail.
write_fact_list.



%% Pretty print the user rules 

print_rule(Rule):-
    rule_description(Rule).

write_rule_list :-
    nl,
    write("USER RULE: "),nl,
    user_rule(N, _Antecedants, _C),
    rule_description(N),
    fail.
write_rule_list.



%% Pretty print the system rules 
r_description(1):-
    write("1. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings, then these two people can meet indoors").

r_description(2):-
    write("2. If there is a city in tier1 then this city allow indoor meetings").

system_rule(Rule):-
    r_description(Rule).



write_why_list:-
    %% LOUISE: What if the node was labelled unprovable?
    y_user_computer(N,F),
    \+ asked_question(F),
    write(N),write(". Why do you beleive "), print_fact(F), write("?"),nl,
    fail.
write_why_list.

write_whynot_list:-
    %% LOUISE: What if the node was labelled unprovable?
    n_user_computer(A,F),
    \+ asked_question(F),
     write(A),write(".Why don't you beleive "), print_fact(F), write("?"),nl,
    fail.
write_whynot_list.



write_w_list:-
    y_computer_user(N,P),
    \+ deduce_backwards(P,_),
    write(N),write(". Why do you beleive "), print_fact(P), write("?"),nl,
    fail.
write_w_list.



write_x_list:-
    n_computer_user(P),
    deduce_backwards(P,_),
    write("Why don't you beleive "), print_fact(P), write("?"),nl,
    fail.
write_x_list.







write_agree_list :-
    agree(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_agree_list.

write_reason_list :-
    reason(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_reason_list.


write_initial_list:-
    initial_question(N,_F,Pretty),
    write(N), write('. '), write(Pretty), nl,
    fail.
write_initial_list.






%% LOUISE:  This should not offer all nodes as a choice.  It should offer everything that is in
%% Y_user_computer (facts the user (should) think the computer knows) and which the user hasn't
%% asked before.
%% It should also allow the user to ask "why not" for everything in N_user_computer (facts the
%% user (should) think the computer doesn't know) and which the users hasn't asked before.
write_ask_list:-
    %% LOUISE: What if the node was labelled unprovable?
    node(N, Fact, _, _),
    write(N), write(". Why do you beleive "), write(Fact), write("?"),nl,
    fail.
write_ask_list.


