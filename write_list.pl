
%% LOUISE:  both write_why_list and write_why_not_list feel a bit redundant to me.
%% The user has already said they want an explanation.
agree(1, "Yes, I agree. Exit.").
agree(2, "No, I disagree. I want an explanation.").

reason(1, "Because it's a user initial fact.").
reason(2, "Because it is a new fact deduced by a rule.").
reason(3, "Exit.").

write_user_fact:-
    write('\n----------USER FACT ----------\n'),nl,
    user_fact(_N, Fact, initial_fact, []),
    print_fact(Fact),nl,
    fail.
write_user_fact.

write_user_rule:-
    write('\n----------USER RULE ----------\n'),nl,
    user_rule(N, _Antecedants, _C),
    print_rule(N),nl,
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
    N1 is N+2,
    (  
     \+node(_,F,unprovable,_)
    ->
        write(N1),write(". Why do you beleive "), print_fact(F), write("?"),nl
    ;   write(N1),write(". Why do not you beleive "), rewrite_fact(F), write("?"),nl
    ),
    fail.
write_why_list.

write_whynot_list:-
    %% LOUISE: What if the node was labelled unprovable?
    n_user_computer(A,F),
    %write(n_user_computer(A,F)),
    \+ asked_question(F),
    aggregate_all(count, y_user_computer(_,_), Count),
    B is A+Count+2,
   (  
    \+node(_,F,unprovable,_)
    ->
        write(B),write(". Why do you beleive "), print_fact(F), write("?"),nl
    ;   write(B),write(". Why do not you beleive "), rewrite_fact(F), write("?"),nl
    ),
    fail.
write_whynot_list.

rewrite_fact(not(H)):-
    print_fact(H).


write_w_list:-
    y_computer_user(N,F),
    \+ deduce_backwards(F,_),
    \+ asked_question(F),
   %\+ node(_N, F,_, _), !,
    write(N),write(". Why do you beleive "), print_fact(F), write("?"),nl,
    fail.
write_w_list.



write_x_list:-
    n_computer_user(F),
    deduce_backwards(F,_),
    \+ asked_question(F),
    %node(_N, F,_, _)
    write("Why don't you beleive "), print_fact(F), write("?"),nl,
    fail.
write_x_list.









write_reason:-
    reason(N, Name),
    write(N), write('. '), write(Name), nl,
    fail.
write_reason.


write_initial_list:-
    initial_question(N,_F,Pretty),
    write(N), write('. '), write(Pretty), nl,
    fail.
write_initial_list.



