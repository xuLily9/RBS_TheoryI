
%% LOUISE:  both write_why_list and write_why_not_list feel a bit redundant to me.
%% The user has already said they want an explanation.


%% Pretty print the facts with nature language
fact_description(residence(X,Y)):-
     write(X), write(" lives in "), write(Y).

fact_description(tier1(X)):-
     write(X), write(" is in tier1"), nl.

fact_description(indoor_meetings_allowed(Y)):-
     write(Y), write(" allows indoor meetings").

fact_description(can_meet_indoors(X, A)):-
    write(X), write(" and "), write(A),write(" can meet indoors").
 
print_fact(Fact):-
    fact_description(Fact).

write_fact_list :-
    write("FACT: "),nl,
     node(_N, Fact, initial_fact, []),
     print_fact(Fact),nl,
     fail.
write_fact_list.


%% Pretty print the rules 
rule_description(rule(1,_,_)):-
    write("1. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings, then these two people can meet indoors."),nl.

rule_description(rule(2,_,_)):-
    write("2. If there is a city in tier1 then this city allow indoor meetings"),nl.

print_rule(Rule):-
    rule_description(Rule).

write_rule_list :-
    write('RULE: '),nl,
    rule(N, Antecedants, C),
    rule_description(rule(N, Antecedants, C)),
    fail.
write_rule_list.






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
    %% LOUISE: What if the node was labelled unprovable?
    node(N, Fact, _, _),
    write(N), write('. '),  write(Fact), nl,
    fail.
write_ask_list.


