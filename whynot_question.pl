:-dynamic node/4, user_fact/2, not_believe/1, believe/1, user_rule/3, different/1.

% why not question section                         
whynot_question(Fact) :- % If the conlusion is false
    repeat,
    print_prompt(bot),
    write('Please select a question or exit:'), nl, !,
    write_whynot_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (   Number =:= 1
    ->  write("User: Why don't you beleive "), write(Fact), write("?"), nl, !,        
        assert(believe(Fact)), !, 
        whynot(Fact), !
    ;   Number =:= 2
    ->  print_prompt(bot), write('Bye'),nl, retract(user_fact(_X, _Y)), !, halt
    ;   write('Not a valid choice, try again...'), nl, fail
    ).


whynot(F):-
    repeat,
    write("Computer: Why do you believe "), write(F), write(" ?"),nl,    % legal move 3: If s = whynot(t) then answer why(t).
    print_prompt(bot),
    write('Select your reason: '), nl,
    write_reason_list,
    print_prompt(user),
    prompt(_, ''),
    read(Number),
    (  Number =:= 1
    -> why_rule(F), nl, !
    ;   Number  =:= 2
    -> write("User: It's an initial fact."),nl,                   % legal move 6
    \+ node(_N, F, initial_fact, []), !,
    \+ user_fact(F,initial_fact), !,
    assert(user_fact(F,initial_fact)), !,
    write("Computer: I have identify the disagreement. "), write(F),write(" is a user's initial fact, not a system's initial fact"),nl, 
    assert(different(F)),!, halt
    ; write('Not a valid choice, try again...'), nl, fail
    ).

%% LOUISE: Case where rule is missing is missting.
%% IN this case the computer
why_rule(F):-
    write("User: Please enter rule number: "),
    %% LOUISE: R should be added to YR_computer_user
    read(R),
    rule(R, A, F),                                 % legal move 8: For some rule label, l ∈ Y Rij then the player may state different rule(l, j, i).
    %% LOUISE: Computer adds all positive literals in A to Y_computer_user
    %% LOUISE: Computer adds all negative literals in a to N_computer user
    %% LOUISE: Computer then selects a fact that is in Y_computer_user and is not a node and asks
    %% why the user believes that fact.
    %% OR the computer picks a fact that is in N_computer_user and is a node and asks why the user
    %% does not believe that fact.
    check(A, N),
    print_prompt(bot),
    write("I cannot deduce "),  write(N), nl,
    write("Computer: I have identified the disagreement. We have a different rule."),nl,
    %% LOUISE: !!!!!! But you don't have a different rule here.  The computer has the rule R but
    %% doesn't agree about the antecedants A !!!
    assert(different(F)),!,halt.

check([],[]).
check([H|T], [H|N]):-
    \+ deduce_backwards(H, _DAG),!, 
    check(T, N).
check([H|T], N):-
    deduce_backwards(H,_DAG),!,
    check(T,N).
