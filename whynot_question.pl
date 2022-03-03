:- use_module(library(random)).

whynot(F):-
    repeat,
    nb_getval(fileOutput,Out),
    write('Covid Advice System: Why do you beleive '),write(Out,'Covid Advice System: Why do you beleive '), print_fact(F), write(Out, '? Please state your reason:\n'),write('? Please state your reason:\n'),
    write_reason,
    write('User: '),
    prompt(_, ''),
    read(Number),
    (   Number  =:= 1
    ->  write(Out,'Because it is an user initial fact.'),
        ( 
            user_fact(_,F,initial_fact,_),
            write('User: Because'),write(Out,'User: Because'), print_fact(F),write(' is an initial fact.'),write(Out,' is an initial fact.'),nl, 
            assert(y_computer_user(N,F)),!,assert(n_user_computer(N,F)),!,
            \+ node(_N, F,_, _), !,
            write('Covid Advice System: I have found the disagreement. User believes '), 
            write(Out, '\n----------DISAGREEMENT----------\n'),
            write(Out, 'Covid Advice System: I have found the disagreement. User believes '),print_fact(F),
            write(Out, ' is an initial fact,but the computer neither believes nor infers it.'), write(' is an initial fact,but the computer neither believes nor infers it.'),
            assert(different(F)),!
        ; 
             \+user_fact(_,F,initial_fact,_),!,
            write('Covid Advice System: It is not an initial user fact,try again...\n'),
            write(Out,'Covid Advice System: It is not a user initial fact, please select another reason.\n'),nl,fail
        )
    ;    Number =:= 2
    ->  write(Out, 'Because it is a new fact deduced by a rule'), because_rule(F), nl, !
    ;    Number =:= 3
    -> write('Covid Advice System: Bye\n')->halt
    ;
        write('Not a valid choice, try again...'), nl, fail
    ).
    

%% LOUISE: Case where rule is missing is missting.
%% IN this case the computer


because_rule(F):-
    repeat,
    nb_getval(fileOutput,Out),
    write('User: Please select a rule number: '),nl,
    write(Out,'User: Please select a rule number: '),
    write_user_rule,
    write('User: '),
    prompt(_, ''),
    read(N),nl,     
    (  
        user_rule(N, A, F),
        rule(_,A,F),
        write(Out,'User:'),
        assert(yr_computer_user(N,A,F)),!, 
        check(A, NL),
        %write(NL),
        pretty_list(NL,_Pretty),
        option_whynot
    ;   

        write('Covid Advice System: I found the disagreement! I do not have this rule'),
        write(Out, '\n----------DISAGREEMENT----------\n'),
        write(Out, 'Covid Advice System: I found the disagreement! I do not have this rule '),print_rule(N),write(Out, ', but the user has it.'),write(', but the user has it.'), nl,
        assert(different(user_rule(N,_,_))),!
    ;   
        write('Not a valid choice, try again...'), nl, fail).





option_whynot :-
    nb_getval(fileOutput,Out),
    write('Covid Advice System: Please select one of the question'),nl,
    write(Out,'Covid Advice System: Please select one of the question\n'),
    write_w_list,
    write_x_list,
    write('User:'),
    read(N),
    (   y_computer_user(N, Fact)
    ->  whynot(Fact)
    ;  n_computer_user(N, Fact)
    ->  whynot(Fact)
    ).




check([],[]).
check([not(H)|T], N):-
    \+ deduce_backwards(H, _DAG),!, 
    check(T, N).
check([H|T], [H|N]):-
    \+ deduce_backwards(H, _DAG),!, 
    check(T, N).
check([H|T], N):-
    deduce_backwards(H,_DAG),!,
    check(T,N).


pretty_list([],"").
pretty_list([Head|Tail],Out):-
    print_top(Head,_HeadPretty),
    pretty_list(Tail,Out).

print_top(Fact,_Pretty):-
    (
        node(_, Fact, unprovable, _)
    ->
        assert(n_computer_user(Fact)),!
    ;   
        aggregate_all(count, y_computer_user(_,_), Count4),
        Num is Count4 +1,
        %write(y_computer_user(Num,Fact)),
        assert(y_computer_user(Num,Fact)),!
    ). 

%% LOUISE: Computer adds all positive literals in A to Y_computer_user
    %% LOUISE: Computer adds all negative literals in a to N_computer user
    %% LOUISE: Computer then selects a fact that is in Y_computer_user and is not a node and asks
    %% why the user believes that fact.
    %% OR the computer picks a fact that is in N_computer_user and is a node and asks why the user
    %% does not believe that fact.