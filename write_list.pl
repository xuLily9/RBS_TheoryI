

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


write_ask_list:-
    node(N, Fact, _, _),
    write(N), write('. '),  write(Fact), nl,
    fail.
write_ask_list.