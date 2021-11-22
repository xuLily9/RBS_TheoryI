

% why not question section                         




whynot(F):-
    nl,
    repeat,
    print_prompt(bot),
    write("Please state your reason: "), nl,
    write_reason_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (  Number =:= 2
    -> why_rule(F), nl, !
    ;   Number  =:= 1
    -> 
        print_prompt(user),
        print_fact(F),
        write(" is an initial fact."),nl, 
        \+ node(_N, F, initial_fact, []), !,
        \+ user_fact(_,F,initial_fact,_), !,
        assert(user_fact(_,F,initial_fact,_)), !,
        write("Computer: I have identify the difference "), print_fact(F),write(" is a user's initial fact, not a system's initial fact"),nl, 
        assert(different(F)),!, halt
    ; write('Not a valid choice, try again...'), nl, fail
    ).



    

%% LOUISE: Case where rule is missing is missting.
%% IN this case the computer
why_rule(F):-
    write("User: Please select a rule number: "),nl,
    print_rule(R),nl,
    yr_user_computer(R1,A,F),
    system_rule(R1),nl,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    assert(yr_computer_user(Number,A,F)),!,    
        
    %% LOUISE: Computer adds all positive literals in A to Y_computer_user
    %% LOUISE: Computer adds all negative literals in a to N_computer user
    %% LOUISE: Computer then selects a fact that is in Y_computer_user and is not a node and asks
    %% why the user believes that fact.
    %% OR the computer picks a fact that is in N_computer_user and is a node and asks why the user
    %% does not believe that fact.

    check(A, N),
    print_prompt(bot),
    write("I cannot deduce "),  
    pretty_print_node_list(N,Pretty),
    write(Pretty),nl.

check([],[]).
check([not(H)|T], [not(H)|N]):-
    \+ deduce_backwards(H, _DAG),!, 
    assert(n_computer_user(H)),
    check(T, N).
check([H|T], N):-
    deduce_backwards(H,_DAG),!,
    assert(y_computer_user(H)),!,
    check(T,N).

