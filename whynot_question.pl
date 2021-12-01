

% why not question section                         




whynot(F):-
    repeat,
    print_prompt(bot), write("Why do you beleive "), print_fact(F), write("?"), nl,
    print_prompt(bot), write("Please state your reason: "), nl,
    write_reason_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (  Number =:= 2
    ->  why_rule(F), nl, !
    ;   Number  =:= 1
    -> 
        print_prompt(user),
        write("Because "),
        print_fact(F),
        write(" is an initial fact."),nl, 
        \+ node(_N, F, initial_fact, []), !,
        \+ user_fact(_,F,initial_fact,_), !,
        assert(user_fact(_,F,initial_fact,_)), !,
        write("Computer: I have identify the difference. User believes "), print_fact(F),write("is an initial fact,but the computer neither believes nor infers it."),nl, 
        assert(different(F)),!, halt
    ; write('Not a valid choice, try again...'), nl, fail
    ).



    

%% LOUISE: Case where rule is missing is missting.
%% IN this case the computer



why_rule(F):-
    write("User: Please select a rule number: "),nl,
    %yr_user_computer(Rule,_,_),
    %system_rule(Rule),nl,
    write_rule_list,
    print_prompt(user),
    prompt(_, ''),
    read(N),nl,
    % assert(yr_computer_user(Number,A,F)),!,      
    (  
        user_rule(N, A, F),
        check(A, NL),
        pretty_list(NL,Pretty),
        option_whynot
    ;   write("The computer don't know this rule "),write(N),write(". I found the difference. Exit."), nl,
        assert(difference(user_rule(N,_,_))),!, halt
    ).



option_whynot :-
    repeat,
    print_prompt(bot),
    write("Please select one of the option:"),nl,
    write_w_list,
   % write_y_list,
    print_prompt(user),
    prompt(_, ''),
    read(N),nl,
    (   y_computer_user(N, Fact)
    ->  whynot(Fact)
   % ;  n_computer_user(N, Fact)
   % ->  why(Fact)
    ;
     write('Not a valid choice, try again...'), nl,fail
    ).




check([],[]).
check([H|T], [H|N]):-
    \+ deduce_backwards(H, _DAG),!, 
    check(T, N).
check([H|T], N):-
    deduce_backwards(H,_DAG),!,
    check(T,N).

check([not(H)|T], [H|N]):-
    \+ deduce_backwards(H, _DAG),!, 
    check(T, N).

check([not(H)|T], N):-
    deduce_backwards(H,_DAG),!,
    check(T,N).

pretty_list([],"").
pretty_list([Head|Tail],Out):-
    print_top(Head,_HeadPretty),
    pretty_list(Tail,Out).

print_top(Fact,_Pretty):-
    print_fact(Fact),
    aggregate_all(count, y_computer_user(_,_), Count),
    N is Count +1,
    assert(y_computer_user(N,Fact)).

pretty_fact(not(Fact),Fact):-
    assert(n_computer_user(not(Fact))),!,
    print_fact(Fact),nl.

%% LOUISE: Computer adds all positive literals in A to Y_computer_user
    %% LOUISE: Computer adds all negative literals in a to N_computer user
    %% LOUISE: Computer then selects a fact that is in Y_computer_user and is not a node and asks
    %% why the user believes that fact.
    %% OR the computer picks a fact that is in N_computer_user and is a node and asks why the user
    %% does not believe that fact.