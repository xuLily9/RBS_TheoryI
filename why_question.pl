
% why question section




why(F):-                                              
    node(_N, F, initial_fact, _NL), !,
    print_prompt(bot),                              
    write("Because "), 
    print_fact(F),
    write("is an initial fact"),nl,
    print_prompt(bot),
    write("I have identify the difference. Computer believes "), print_fact(F),write(" ,but the user doesn't believe it. Exit."),nl, 
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
    nl,
    %% LOUISE:  You also want to store these facts in a list of facts that the user now knows the computer believes (or does not believe for negative literals)
    %% So you should be extending Y_user_computer and N_user_computer
    pretty_print_node_list(NL,Pretty),
    write(Pretty),
    nl.






pretty_print_node_list([],"").
pretty_print_node_list([Head|Tail],Out):-
    print_top_level(Head,_HeadPretty),
    pretty_print_node_list(Tail,Out).

print_top_level(node(_ID,Fact,_Rule,_NL),Pretty):-
    pretty_fact(Fact,Pretty).
print_top_level(node(_ID,not(Fact),unprovable,_NL),Pretty):-
    pretty_fact(not(Fact),Pretty).

pretty_fact(Fact,Fact):-
    \+ y_user_computer(_N,Fact)
    ->  aggregate_all(count, y_user_computer(_,_), Count),
        N is Count +1,
        assert(y_user_computer(N,Fact)),!,
        print_fact(Fact),nl
    ;
        print_fact(Fact),nl.


pretty_fact(not(Fact),Fact):-
    assert(n_user_computer(not(Fact))),!,
    print_fact(Fact),nl.

