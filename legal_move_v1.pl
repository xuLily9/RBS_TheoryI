:- [deduce_backwards],[why_question],[whynot_question],[write_list].
:-dynamic node/4, user_fact/4, different/1, asked_question/1,n_computer_user/1,y_computer_user/2,y_user_computer/2,n_user_computer/2,yr_user_computer/3,yr_computer_user/3.

chat:-
    print_welcome,
    print_conclusion(Conclusion,F),
    assert(asked_question(F)),
    ask_agree(Conclusion,F),
    conversations.

print_welcome:-
    exampleOpen,
    write_user_fact,
    write_user_rule.

print_conclusion(Conclusion,F):-
    write('\n----------CONVERSATION ----------\n'),nl,
    nb_getval(fileOutput,Out),
    write('Covid Advice System: '),conclusion(F), 
    write(Out,'\nCovid Advice System: '),
    (
        deduce_backwards(F,node(_ID, F, _R, _DAG))
    ->  
        print_fact(F),write(': True.\n'),nl,
        write(Out,' is true\n'),
        Conclusion =true
    ;   
        print_fact(F),write(': False.\n'),nl,
        write(Out,' is false\n'),
        Conclusion = false
        
    ).

ask_agree(Conclusion,F):-
    repeat,
    nb_getval(fileOutput,Out),
    write('Covid Advice System: Do you agree with this conclusion?\n'),
    write(Out, 'Covid Advice System: [Do you agree with this conclusion?]\n'),
    yes_no,
    write('User:'),read(N),
    (   N =:= 1
    ->   write(Out,'User: YES, BYE\n'),exampleClose,write('Covid Advice System: Bye\n')->halt
    ;   N =:= 2
    ->   write(Out,'User: NO\n'),
    
        (   Conclusion =true
        ->  database(Conclusion,F),
            write('User: Why do you believe '),
            write(Out,'User: Why do you believe '), print_fact(F), write(Out,'?\n'),write('?\n'), 
            why(F)
        ;   database(Conclusion,F),
            write('User: Why do not you believe '), 
            write(Out,'User: Why do not you believe '), print_fact(F), write('?\n'),write(Out, '?\n'), whynot(F)
        )
    ;   write("Not a valid choice, try again..."), nl,fail
    ).


database(Conclusion,F):-
   (    Conclusion =true
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
        %write(n_user_computer(B,F)),
        aggregate_all(count, y_computer_user(_,_), Count3),
        C is Count3 +1,
        assert(y_computer_user(C,F)),!,     %% LOUISE: At this point the computer should add F to Y_computer_user and N_user_computer
        assert(asked_question(F)),!
    ).



conversations:-
    repeat,
    write('\n----------SELECT A QUESTION OR EXIT----------\n'),nl,
    dialogue.

dialogue:-
    repeat,
    nb_getval(fileOutput,Out),
    write('Covid Advice System: Please select one of the option:\n'),
    write('1. Exit\n'),
    write('2. I do not have this rule used by computer\n'),
    write(Out,'\nCovid Advice System: Please select one of the option:\n'),
    write(Out,'\n1. Exit\n'),
    write(Out,'\n2. I do not have this rule used by computer\n'),
    write_why_list,!,
    write_whynot_list,!,
    write('User:'),
    prompt(_, ''),
    read(N),
    (   
        N=:= 1
     -> write(Out,'\nCovid Advice System:Bye\n'),exampleClose,write('Covid Advice System:Bye\n')->halt
    ;   
        N=:= 2
    ->  write(Out, '\n----------DISAGREEMENT----------\n'),
        write(Out,'\nCovid Advice System: I have found the disagreement. The computer used a rule that the user do not have it.\n'),
        write('\nCovid Advice System: I have found the disagreement. The computer used a rule that the user do not have it.\n'), conversations
    ;   
        N1 is N-1,
        y_user_computer(N1, Fact), N \=1, N \=2
        ->  write(Out,'\nUser: Why do you believe '),write('\nUser: Why do you believe '),print_fact(Fact), write('?\n'),write(Out,'?\n'),
            assert(asked_question(Fact)),
            why(Fact), conversations
    ;   
        aggregate_all(count, y_user_computer(_,_), Count),
        A is N-Count-1,
        n_user_computer(A,Fact), N \=1, N \=2
         -> write(Out,'\nUser: Why do not you believe '),write('\nUser: Why do not you believe '),print_fact(Fact), write('?\n'),write(Out,'?\n'),
            assert(asked_question(Fact)),
            whynot(Fact)
    ;   
        write('Not a valid choice, try again...'), nl,fail
    ).


exampleOpen:-
    open('file.txt',write, Out),
    write(Out,'\n----------CONVERSATION REPORT ----------\n'),
    nb_setval(fileOutput,Out).

exampleClose:-
    nb_getval(fileOutput,Out),
    close(Out).
       






