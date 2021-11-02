:-dynamic node/4, user_fact/2, not_believe/1, believe/1, user_rule/3, different/1.

% why question section 
why_question(Fact) :-  % If the conclusion is true
    repeat,
    print_prompt(bot),
    write('Please select a question or exit:'), nl, !,
    write_why_list, 
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (   Number =:= 1
    ->  write('You selected question: '), write("Why do you beleive "),write(Fact), write("?"), nl, !,
        assert(not_believe(Fact)), !,
        why(Fact), ! 
    ;   Number =:= 2
    ->  print_prompt(bot), write('Bye'),nl, retract(user_fact(_X, _Y)), !, halt
    ;   write('Not a valid choice, try again...'), nl, fail
    ).


why(F):-                                              % legal move 1: If s = why(t) and t ∈ Fi then initial(t)
    node(_N, F, initial_fact, _NL), !,
    print_prompt(bot),                              % legal move 6:
    write("Because it is an initial fact"), nl,
     \+ user_fact(F, initial_fact),
    write("Computer: I have identify the disagreement. "), write(F),write(" is a system's initial fact, not a user initial fact"),nl, 
    assert(different(F)),!, halt.
  
why(F):-                                              % legal move 1: If s = why(t) and t ∈ Fi then initial(t)
    user_fact(F, initial_fact), !,
    print_prompt(bot),
    write("Because it is a user initial fact"), nl.

why(F):-                                             % legal move 2: Ifs=why(t) and t∈Fi thenforsomenoden=⟨t,l⟩∈Gi 
    node(_N, F, R, NL), !,                           % A→t where A are the terms for n parent nodes.
    rule(R, _A, F),
    print_prompt(bot),
    write("Because "),
    write(F),
    write(" is deduced using rule "),
    write(R),
    write(" from facts:"),
    nl,
    pretty_print_node_list(NL,Pretty),
    write(Pretty).


pretty_print_node_list([],"").
pretty_print_node_list([Head|Tail],Out):-
    print_top_level(Head,HeadPretty),
    pretty_print_node_list(Tail,Out).

print_top_level(node(_ID,Fact,_Rule,_NL),Pretty):-
    pretty_fact(Fact,Pretty).

pretty_fact(Fact,Fact):-
    write(Fact),nl.



