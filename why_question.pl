%:-dynamic node/4, user_fact/2, not_believe/1, believe/1, user_rule/3, different/1.
:-dynamic node/4, asked_question/1,user_fact/2, user_rule/3, different/1, user_question/1,n_computer_user/1,y_computer_user/1,y_user_computer/1,n_user_computer/1.

% why question section


why_question(Fact) :-  
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

why(F):-                                              
    node(_N, F, initial_fact, _NL), !,
    print_prompt(bot),                              
    write("Because it is an initial fact"), nl,
    write("Computer: I have identify the disagreement. "), write(F),write(" is a system's initial fact, not a user initial fact"),nl, 
    assert(different(F)),!, halt.
  
why(F):-                                            
    node(_N, F, R, NL), !,                           
    rule(R, _A, F),
    print_prompt(bot),
    write("Because "),
    write(F),
    write(" is deduced using rule "),
    write(R),
    yr_user_computer(R),
    write(" from facts:"),
    nl,
    %% LOUISE:  You also want to store these facts in a list of facts that the user now knows the computer believes (or does not believe for negative literals)
    %% So you should be extending Y_user_computer and N_user_computer
    pretty_print_node_list(NL,Pretty),
    write(Pretty).


options :-
    print_prompt(bot),
    write("Please select one of the options:"),nl,
    write_option_list,
    print_prompt(user),
    prompt(_, ''),
    read(Nanswer),
    (   Nanswer =:= 1
    ->  
    ;   write('Not a valid choice, try again...'), nl
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
    write(Fact),nl.



