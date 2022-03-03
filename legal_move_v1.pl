:- [deduce_backwards],[why_question],[whynot_question],[write_list].
:-dynamic node/4, user_fact/4, different/1, asked_question/1,
why_q/1,whynot_q/1,n_computer_user/1,y_computer_user/2,y_user_computer/2,n_user_computer/2,yr_user_computer/3,yr_computer_user/3.

chat:-
    print_welcome,
    print_conclusion(Conclusion,F),
    ask_agree(Conclusion,F),
    database(Conclusion,F),
    exampleClose.

print_welcome:-
    exampleOpen,
    write_user_fact,
    write_user_rule.

print_conclusion(Conclusion,F):-
    write('\n----------CONVERSATION ----------\n'),nl,
    print_prompt(bot),conclusion(F), 
    (
        deduce_backwards(F,node(_ID, F, _R, _DAG))
    ->  
        nb_getval(fileOutput,Out),
        print_fact(F),write(' is true.\n'),nl,
        write(Out,' is true\n'),
        Conclusion =true
    ;   
        nb_getval(fileOutput,Out),
        print_fact(F),write(' is false.\n'),nl,
        write(Out,' is false\n'),
        Conclusion = false
    ).

ask_agree(Conclusion,F):-
    repeat,
    print_prompt(bot), write('Do you agree with this conclusion?\n'),
    yes_no,
    print_prompt(user),
    read(N),
    (   N =:= 1
    ->  print_prompt(bot), write('Bye\n'),!,halt
    ;   N =:= 2
    ->  
        (
            Conclusion =true
            ->print_prompt(user), write('Why do you believe '), print_fact(F), write('?\n'),nl, why(F), conversations
        ;   
            print_prompt(user), write('Why do not you believe '), print_fact(F), write('?\n'), nl,whynot(F)
        )
    ;   write("Not a valid choice, try again..."), nl,fail
    ).


database(Conclusion,F):-
   (
    Conclusion =true
    ->
        assert(n_computer_user(F)),!,     %% LOUISE: At this point the computer should add F to N_computer_user and Y_user_computer
        aggregate_all(count, y_user_computer(_,_), Count1),
        A is Count1 +1,
        assert(y_user_computer(A,F)),!,
        assert(asked_question(F)),!
    ;
        aggregate_all(count, n_user_computer(_,_), Count2),
        B is Count2 +1,
        assert(n_user_computer(B,F)),!,
        aggregate_all(count, y_computer_user(_,_), Count3),
        C is Count3 +1,
        assert(y_computer_user(C,F)),!,     %% LOUISE: At this point the computer should add F to Y_computer_user and N_user_computer
        assert(asked_question(F)),!
    ).



conversations:-
    nl,
    repeat,
    option_why.


option_why :-
    repeat,
    print_prompt(bot),
    write("Please select one of the option:"),nl,
    write("1. I don't know about this rule used by computer."),nl,
    write("2. Exit"),nl,
    write_why_list,!,
    write_whynot_list,!,
    print_prompt(user),
    prompt(_, ''),
    read(N),
    (   
        N=:= 1
    ->  print_prompt(bot), write("I have identify the difference: the computer used a rule that you don't know about it."),nl,!
    ;   
        N=:= 2
    ->  write('Bye'),!,halt
    ;   
        N1 is N-1,
        y_user_computer(N1, Fact), N \=1, N \=2
        ->  write('You selected: '), write("Why do you believe "),print_fact(Fact), write("?"), nl, !,
            nl,
            assert(asked_question(Fact)),
            assert(why_q(Fact)),
            why(Fact)
    ;   
        aggregate_all(count, y_user_computer(_,_), Count),
        A is N-Count-1,
        n_user_computer(A,Fact), N \=1, N \=2
         -> write('You selected: '), write("Why do you believe "),print_fact(Fact), write("?"), nl, !,
            nl,
            assert(asked_question(Fact)),
            print_prompt(bot), write("Why don't you beleive "), print_fact(Fact), write("?"), nl,
            assert(whynot_q(Fact)),
            whynot(Fact)
    ;   
        write('Not a valid choice, try again...'), nl,fail
    ).


print_prompt(bot):-
        my_icon(X), write(X), write(': '), flush_output.
print_prompt(user):-
        user_icon(X), write(X), write(': '), flush_output.

my_icon("Covid Advice System").
user_icon("User").

exampleOpen:-
    open('file.txt',write, Out),
    write(Out,'\n----------CONVERSATION REPORT ----------\n'),
    nb_setval(fileOutput,Out).

exampleClose:-
    nb_getval(fileOutput,Out),
    close(Out).
       






