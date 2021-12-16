:- [deduce_backwards],[why_question],[whynot_question],[write_list].
:-dynamic node/4, user_fact/4, different/1, user_question/1,n_computer_user/1,y_computer_user/2,y_user_computer/2,n_user_computer/2,yr_user_computer/3,yr_computer_user/3, asked_question/1.

agree(1, "Yes, I agree. Exit.").
agree(2, "No, I disagree. I want an explanation.").

reason(1, "It's an initial fact.").
reason(2, "It is deduced by a rule.").


print_prompt(bot):-
        my_icon(X), write(X), write(': '), flush_output.
print_prompt(user):-
        user_icon(X), write(X), write(': '), flush_output.

my_icon("Covid Advice System").
user_icon("User Response").


chat:-
    write_fact_list,!,
    write_rule_list,!,
    print_welcome.


print_welcome:-
    nl,
    repeat,
    write("Please select a question: "),nl,
    write_initial_list,
    print_prompt(user),
    read(N),
    (
        initial_question(N,F,_Pretty),
        main(F)
    ;   write('Not a valid choice, try again...'), nl, fail
    ).


main(F):-
    deduce_backwards(F,node(_ID, F, _R, _DAG))
    -> 
        print_prompt(bot),print_fact(F), write(' is true.'),nl,!,
        disagree_true(F),!,
        add_1(F),  
        why(F),                          
        conversations
    ;
        print_prompt(bot),print_fact(F), write(' is false.'),nl,!,
        disagree_false(F),!,
        add_2(F).



disagree_true(F):-
    nl,
    repeat,
    print_prompt(bot), write("Do you agree?"),nl,
    write_agree_list,
    print_prompt(user),
    prompt(_, ''),
    read(N),
    (   N =:= 1
    ->  print_prompt(bot), write("Bye"),nl,!, halt
    ;   N =:= 2
    ->  print_prompt(user), write("Why do you beleive "), print_fact(F), write("?"),nl,!
    ;   write("Not a valid choice, try again..."), nl,fail
    ).

disagree_false(F):-
    nl,
    repeat,
    print_prompt(bot), write("Do you agree?"),nl,
    write_agree_list,
    print_prompt(user),
    prompt(_, ''),
    read(N),nl,
    (   N =:= 1
    ->  print_prompt(bot), write("Bye"),nl,!, halt
    ;   N =:= 2
    ->  whynot(F)
    ;   write("Not a valid choice, try again..."), nl,fail
    ).




add_1(F):-
    assert(n_computer_user(F)),!,     %% LOUISE: At this point the computer should add F to N_computer_user and Y_user_computer
    aggregate_all(count, y_user_computer(_,_), Count),
    N_1 is Count +1,
    assert(y_user_computer(N_1,F)),!,
    assert(asked_question(F)),!.  



add_2(F):-
    aggregate_all(count, n_user_computer(_,_), Count),
    N_2 is Count +1,
    assert(n_user_computer(N_2,F)),!,
    aggregate_all(count, y_computer_user(_,_), C),
    B is C +1,
    assert(y_computer_user(B,F)),!,     %% LOUISE: At this point the computer should add F to Y_computer_user and N_user_computer
    assert(asked_question(F)),!.




conversations:-
    repeat,
    option_why, 
    different(_),!,halt.


option_why :-
    repeat,
    print_prompt(bot),
    write("Please select one of the option:"),nl,
    write("1. I don't know about this rule used by computer."),nl,
    write_why_list,!,
    write_whynot_list,!,
    print_prompt(user),
    prompt(_, ''),
    read(N),
    (   
        N=:= 1
    ->  print_prompt(bot), write("I have identify the difference: the computer used a rule that you don't know about it."),nl,!, halt
    ;   
        N1 is N,
        y_user_computer(N1, Fact), N \=1
        ->  write('You selected: '), write("Why do you beleive "),print_fact(Fact), write("?"), nl, !,
            nl,
            why(Fact)
    ;   
        aggregate_all(count, y_user_computer(_,_), Count),
        A is N-Count,
        n_user_computer(A,Fact), N \=1
         -> write('You selected: '), write("Why you beleive "),print_fact(Fact), write("?"), nl, !,
            nl,
            whynot(Fact)
    ;   
        write('Not a valid choice, try again...'), nl,fail
    ).


 










