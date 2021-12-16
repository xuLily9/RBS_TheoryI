
% why question section




why(F):-                                    
    node(_N, F, initial_fact, _NL), !,
    print_prompt(bot),                              
    write("Because computer believes "), 
    print_fact(F),
    write(" is an initial fact."),nl,
    print_prompt(bot),
    write("I have identify the difference. Computer believes "), print_fact(F),write(" is an initial fact,but the user doesn't believe it. Exit."),nl, 
    assert(different(F)),!, halt.
  
why(F):-
    node(_N, F, R, NL), !,                           
    rule(R, A, F),
    print_prompt(bot),
    write("Because "),
    print_fact(F),
    write(" is deduced using rule "),
    system_rule(R),
    assert(asked_question(F)),!,
    assert(yr_user_computer(R, A, F)),!,
    write(", from facts:"),
    %write(NL),
    nl,
    %% LOUISE:  You also want to store these facts in a list of facts that the user now knows the computer believes (or does not believe for negative literals)
    %% So you should be extending Y_user_computer and N_user_computer
    pretty_print_node_list(NL,Pretty),
    write(Pretty),
    nl.






pretty_print_node_list([],"").
pretty_print_node_list([Head|Tail],Out):-
    %write(Head),nl,
    pretty_head(Head),
   % print_top_level(Head,_Pretty),
    pretty_print_node_list(Tail,Out).


pretty_head(node(_, Fact, _Rule, _)):-
    \+ node(_, Fact, unprovable, _)
    ->
        (\+ y_user_computer(_N,Fact)
        ->  aggregate_all(count, y_user_computer(_,_), Count),
             N is Count +1,
            assert(y_user_computer(N,Fact)),!,
            print_fact(Fact),nl
        ;
            print_fact(Fact),nl
        )
    ;   
        (\+ n_user_computer(_N_2,Fact)
        ->  
            aggregate_all(count, n_user_computer(_,_), A),
            N_2 is A +1,
            assert(n_user_computer(N_2,Fact)),!,
            print_fact(Fact),nl
        )
    .
 

    





