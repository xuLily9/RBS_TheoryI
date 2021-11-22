
% why question section


why_question(F) :-  
    repeat,
    write_why_list,
    print_prompt(user),
    read(N),
    (    N =:= 1
        ->write('You selected: '), write("Why do you beleive "),write(Fact), write("?"), nl, !,
        %% LOUISE:  At this point Fact should also be removed from the list of facts the user can ask about.
        assert(asked_question(Fact)),!,
        assert(n_computer_user(Fact)), !,
        assert(y_user_computer(Fact)),!,
        why(Fact), ! 
    ;   write('Not a valid choice, try again...'), nl, fail
    ).

why(F):-                                              
    node(_N, F, initial_fact, _NL), !,
    print_prompt(bot),                              
    write("Because "), 
    print_fact(F),
    write("is an initial fact"),nl,
    print_prompt(bot),
    write("I have identify the difference "), write(F),write(" is a one of the computer's initial fact. Exit."),nl, 
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



question(Fact) :-  
    repeat,
    %% LOUISE: I recommend putting the first fact as a choice and then using write_ask_list here.
    write_ask_list,
    print_prompt(user),
    read(N),
    node(N, Fact, _, _),
    (   node(N, Fact, _, _)
        %y_user_computer(Fact)
        ->write('You selected: '), write("Why do you beleive "),write(Fact), write("?"), nl, !,
        %% LOUISE:  At this point Fact should also be removed from the list of facts the user can ask about.
        assert(asked_question(Fact)),!,
        assert(n_computer_user(Fact)), !,
        assert(y_user_computer(Fact)),!,
        why(Fact), ! 
    ;   write('Not a valid choice, try again...'), nl, fail
    ).




pretty_print_node_list([],"").
pretty_print_node_list([Head|Tail],Out):-
    print_top_level(Head,HeadPretty),
    pretty_print_node_list(Tail,Out).

print_top_level(node(_ID,Fact,_Rule,_NL),Pretty):-
    pretty_fact(Fact,Pretty).

pretty_fact(Fact,Fact):-
    assert(y_user_computer(Fact)),!,
    assert(n_user_computer(Fact)),!,
    print_fact(Fact),nl.



