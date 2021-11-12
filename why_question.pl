:-dynamic node/4, user_fact/2, not_believe/1, believe/1, user_rule/3, different/1.

% why question section 
why_question(Fact) :-  % If the conclusion is true
    repeat,
    print_prompt(bot),
    write('Please select a question or exit:'), nl, !,
    %% LOUISE: I recommend putting the first fact as a choice and then using write_ask_list here.
    write_why_list, 
    print_prompt(user),
    prompt(_, ''),
    %% LOUISE: and adapting this bit accordingly so it will work with multiple choices.
    read(Number),
    (   Number =:= 1
    ->  write('You selected question: '), write("Why do you beleive "),write(Fact), write("?"), nl, !,
        %% LOUISE:  At this point Fact should also be removed from the list of facts the user can ask about.
        assert(not_believe(Fact)), !,
        why(Fact), ! 
    ;   Number =:= 2
     %% LOUISE: Why do you retract the user fact after they have exited the program?
    ->  print_prompt(bot), write('Bye'),nl, retract(user_fact(_X, _Y)), !, halt
    ;   write('Not a valid choice, try again...'), nl, fail
    ).


why(F):-                                              % legal move 1: If s = why(t) and t ∈ Fi then initial(t)
    node(_N, F, initial_fact, _NL), !,
    print_prompt(bot),                              % legal move 6:
    write("Because it is an initial fact"), nl,
    %% LOUISE: You shouldn't have to check here that the user doesn't have this as an initial fact.  Since the user shouldn't be able to ask this question
    %% if the user has it as an initial fact.
    \+ user_fact(F, initial_fact),
    write("Computer: I have identify the disagreement. "), write(F),write(" is a system's initial fact, not a user initial fact"),nl, 
    assert(different(F)),!, halt.
  
%% LOUISE:  The computer shouldn't ever answer that something is the case because it is the user's initial fact.  I would be inclined to comment out this
%% clause and see if something fails.
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
    %% LOUISE:  R is now a rule the user knows the computer has.  R should be added to YR_user_computer
    write(" from facts:"),
    nl,
    %% LOUISE:  You also want to store these facts in a list of facts that the user now knows the computer believes (or does not believe for negative literals)
    %% So you should be extending Y_user_computer and N_user_computer
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



