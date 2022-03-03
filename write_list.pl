
%% LOUISE:  both write_why_list and write_why_not_list feel a bit redundant to me.
%% The user has already said they want an explanation.
agree(1, "Yes, I agree. Exit.").
agree(2, "No, I disagree. I want an explanation.").

reason(1, "Because it's an initial fact.").
reason(2, "Because it is deduced by a rule.").

write_user_fact:-
    write('\n----------USER FACT ----------\n'),nl,
    user_fact(_N, Fact, initial_fact, []),
    print_fact(Fact),nl,
    fail.
write_user_fact.

write_user_rule:-
    write('\n----------USER RULE ----------\n'),nl,
    user_rule(N, _Antecedants, _C),
    rule_description(N),
    fail.
write_user_rule.

print_fact(Fact):-
    fact_description(Fact).
print_rule(Rule):-
    rule_description(Rule).


yes_no:-
    agree(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
yes_no.

write_why_list:-
    %% LOUISE: What if the node was labelled unprovable?
    y_user_computer(N,F),
    \+ asked_question(F),
    N1 is N+1,
    write(N1),write(". Why do you beleive "), print_fact(F), write("?"),nl,
    fail.
write_why_list.

write_whynot_list:-
    %% LOUISE: What if the node was labelled unprovable?
    n_user_computer(A,F),
    \+ asked_question(F),
    aggregate_all(count, y_user_computer(_,_), Count),
    B is A +Count+1,
    write(B),write(". Why do you beleive "), print_fact(F), write("?"),nl,
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



