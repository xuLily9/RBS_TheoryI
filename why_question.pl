why(F):- 
    nb_getval(fileOutput,Out),                                   
    node(_N, F, initial_fact, _NL), !,                              
    write('\nCovid Advice System: Because computer believes '), 
    write(Out,'\nCovid Advice System: Because computer believes '), 
    print_fact(F),
    write(' is an initial fact.\n'),
    write(Out,' is an initial fact.\n'),
    write(Out, '\n----------DISAGREEMENT----------\n'),
    write(Out, '\nCovid Advice System: I have found the disagreement. Computer believes '), 
    write('\nCovid Advice System: I have found the disagreement. Computer believes '), print_fact(F),write(' is an initial fact, but the user does not have it.\n'),nl, 
    write(Out,' is an initial fact, but the user does not have it.\n'),
    assert(different(F)),!.
  
why(F):-
    nb_getval(fileOutput,Out), 
    node(_N, F, R, NL), !,                           
    rule(R, A, F),
    write('\nCovid Advice System: Because '),
    write(Out,'\nCovid Advice System: Because '),
    print_fact(F),
    write(' is deduced using RULE '),
    write(Out,' is deduced using RULE '),
    system_rule(R),
    assert(asked_question(F)),!,
    assert(yr_user_computer(R, A, F)),!,
    write('---FROM FACTS---\n'),
    write(Out,'\n---FROM FACTS---\n'),
    pretty_print_node_list(NL,Pretty),
    write(Pretty),
    write(Out, Pretty),
    nl.

%% LOUISE:  You also want to store these facts in a list of facts that the user now knows the computer believes (or does not believe for negative literals),So you should be extending Y_user_computer and N_user_computer
 

pretty_print_node_list([],"").
pretty_print_node_list([Head|Tail],Out):-
    %write(Head),nl,
    pretty_head(Head),
   % print_top_level(Head,_Pretty),
    pretty_print_node_list(Tail,Out).


pretty_head(node(_, Fact, _Rule, _)):-
        (\+ y_user_computer(_N,Fact)
        ->  aggregate_all(count, y_user_computer(_,_), Count),
             N is Count +1,
            assert(y_user_computer(N,Fact)),!,
            print_fact(Fact),nl
        ;
            print_fact(Fact),nl
        ).

pretty_head(node(_, not(H), _, _)):-
    \+ n_user_computer(_N_2,H)
    ->  
        aggregate_all(count, n_user_computer(_,_), A),
        N_2 is A +1,
        assert(n_user_computer(N_2,H)),!,
        print_fact(H),nl.
 

