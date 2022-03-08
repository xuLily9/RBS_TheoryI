:- use_module(library(random)).

whynot(F):-
    repeat,
    nb_getval(fileOutput,Out),
    write('\nCovid Advice System: Why do you beleive '),
    write(Out,'\nCovid Advice System: Why do you beleive '), print_fact(F), write(Out, '? Please state your reason:\n'),write('? Please state your reason:\n'),
    write_reason,
    write('User: '),
    prompt(_, ''),
    read(Number),
    (   Number  =:= 1
    ->  write(Out,'Because it is an user initial fact.'),
        ( 
            user_fact(_,F,initial_fact,_),
            write('User: Because '),write(Out,'User: Because '), print_fact(F),write(' is an initial fact.'),write(Out,' is an initial fact.'),nl, 
            aggregate_all(count, y_computer_user(_,_), X),
            aggregate_all(count, n_user_computer(_,_), Y),
            X1 is X +1,
            Y1 is Y+1,
            assert(y_computer_user(X1,F)),!,
            assert(n_user_computer(Y1,F)),!,
            \+ node(_N, F,_, _), !,
            write('Covid Advice System: I have found the disagreement. User believes '), 
            write(Out, '\n----------DISAGREEMENT----------\n'),
            write(Out, 'Covid Advice System: I have found the disagreement. User believes '),print_fact(F),
            write(Out, ' is an initial fact,but the computer neither believes nor infers it.'), write(' is an initial fact,but the computer neither believes nor infers it.\n'),nl,
            assert(different(F)),!, option_whynot
        ; 
            \+user_fact(_,F,initial_fact,_),!,
            write('Covid Advice System: It is not an initial user fact,please select another reason.\n'),whynot(F),
            write(Out,'Covid Advice System: It is not a user initial fact, please select another reason.\n'),nl,fail
        )
    ;    Number =:= 2
    ->  write(Out, 'Because it is a new fact deduced by a rule'), reason_rule(F), nl, !
    ;    Number =:= 3
    -> write(Out,'Covid Advice System:Bye\n'),write('Covid Advice System: Bye\n')->halt
    ;
        write('Not a valid choice, try again...'), nl, fail
    ).
    

%% LOUISE: Case where rule is missing is missting.
%% IN this case the computer


reason_rule(F):-
    repeat,
    nb_getval(fileOutput,Out),
    write('User: Please select a rule number: '),nl,
    write(Out,'User: Please select a rule number: '),
    write_user_rule,
    write('User: '),
    prompt(_, ''),
    read(N),nl,     
    (  
        (   
            user_rule(N, A, F)
        ->
            (
            rule(_,A,F)
        ->
            write(Out,'User:'),
            assert(yr_computer_user(N,A,F)),!, 
            check(A, NL),
            pretty_list(NL,_Pretty),
            %write('Covid Advice System:'),
            option_whynot
         ;   

            write('Covid Advice System: I found the disagreement! I do not have this rule'),
            write(Out, '\n----------DISAGREEMENT----------\n'),
            write(Out, 'Covid Advice System: I found the disagreement! I do not have this rule '),print_rule(N),write(Out, ', but the user has it.'),write(', but the user has it.'), nl,
            assert(different(user_rule(N,_,_))),!, option_whynot
            )
        ;   write('Covid Advice System: This rule are not used in deduction, please choose another rule.'),
            write(Out,'Covid Advice System: This rule are not used in deduction, please choose another rule.'),
            reason_rule(F)

        )
    ;   
        write('Not a valid choice, try again...'), nl, fail).


option_whynot :-
    %nb_getval(fileOutput,Out),
    %write('\nCovid Advice System: '),
    %write(Out,'\nCovid Advice System: '),
    write_w_list,
    write_x_list,
    choose(F),
    write('User:'),
    whynot(F).

choose(F):-
    computer_ask_user(F),
    \+asked_question(F),
    assert(asked_question(F)), whynot(F).


check([],[]).
check([not(H)|T], N):-
    \+ deduce_user(H, _DAG),!, 
    assert(n_computer_user(not(H))),
    check(T, N).
check([H|T], [H|N]):-
    \+ deduce_user(H, _DAG),!, 
    check(T, N).
check([H|T], N):-
    deduce_user(H,_DAG),!,
    check(T,N).


pretty_list([],"").
pretty_list([Head|Tail],Out):-
    print_top(Head,_HeadPretty),
    pretty_list(Tail,Out).

print_top(Fact,_Pretty):-
    \+node(_,Fact,unprovable,_)
    ->
        aggregate_all(count, y_computer_user(_,_), Count4),
        Num is Count4 +1,
        assert(y_computer_user(Num,Fact)),!.

%% LOUISE: Computer adds all positive literals in A to Y_computer_user
    %% LOUISE: Computer adds all negative literals in a to N_computer user
    %% LOUISE: Computer then selects a fact that is in Y_computer_user and is not a node and asks
    %% why the user believes that fact.
    %% OR the computer picks a fact that is in N_computer_user and is a node and asks why the user
    %% does not believe that fact.