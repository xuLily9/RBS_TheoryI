:- [deduce_backwards],[why_question],[whynot_question],[write_list].
:-dynamic node/4, user_fact/2, user_rule/3, different/1, user_question/1,n_computer_user/1,y_computer_user/1,y_user_computer/1,n_user_computer/1,yr_user_computer/1.

option(1,"Computer use a rule that I didn't know").
option(2,"Ask why about any fact in Y_user_computer that I haven't asked about before").
option(3, "Ask whynot about any fact in N_user_computer that I haven't asked about before.")


fact(1, "Yes, it is a initial fact").
fact(2, "No, I need some explanations about this fact").

choice(1, "Yes, I am satisfied. Exit.").
choice(2, "No, I need more explanations.").

reason(1, "Because of a rule.").
reason(2, "It's an initial fact.").

agree(1, "Yes, I agree. Exit.").
agree(2, "No, I disagree.").

answer(1, "A fact").
answer(2, "Exit").

question(1,"Can Karl and mary can meet?").


chat:-
    write_fact_list,!,
    write_rule_list,!,
    print_welcome,
    conversations.


print_welcome:-
    initial_question(N,Q,Pretty),
    write("Question: "), write(Pretty),nl,
    conclusion(Q).

conclusion(F):-
    deduce_backwards(F,node(_ID, F, _R, _DAG))
    -> print_prompt(bot),print_fact(F), write(' is true.'), write(" Do you agree?"),nl, !,
       agree,!,
       assert(n_computer_user(F)),!,
       assert(y_user_computer(F)),!,
     %% LOUISE: At this point the computer should add F to N_computer_user and Y_user_computer
       why_question(F)
    ;
        print_prompt(bot),write(F), write(' is false.'),write(" Do you agree?"), nl,!,
        agree,!,
        assert(y_computer_user(F)),!,
        assert(n_user_computer(F)),!,
       %% LOUISE: At this point the computer should add F to Y_computer_user and N_user_computer
        whynot_question(F),!.


conversations:-
    repeat,
    read_agree,  
    write("Computer: What do you want to know?"), nl,
    read_answer(_N),
    different(_),!,halt.
 
print_prompt(bot):-
        my_icon(X), write(X), write(': '), flush_output.
print_prompt(user):-
        user_icon(X), write(X), write(': '), flush_output.

my_icon("Covid Advice System").
user_icon("User Response").


agree :-
    write_agree_list,
    print_prompt(user),
    prompt(_, ''),
    read(Nanswer),
    (   Nanswer =:= 1
    ->  print_prompt(bot), write('Bye'),nl,!, halt
    ;   Nanswer =:= 2
    ->  print_prompt(bot), write("Please select a question or exit: "),nl,!
    ;   write('Not a valid choice, try again...'), nl
    ).


read_agree :-
    write("Computer: Are you satisfied with the results? or you require additional explanations"),nl,
    write_choice_list,
    print_prompt(user),
    prompt(_, ''),
    read(Nanswer),
    (   Nanswer =:= 1
    ->  print_prompt(bot), write('Bye'),nl,!, halt
    ;   Nanswer =:= 2
    ->  print_prompt(bot), write('Okay, let us move on.'),nl,!
    ;   write('Not a valid choice, try again...'), nl
    ).


read_answer(Nanswer) :-
    repeat,
    write_answer_list,
    print_prompt(user),
    prompt(_, ''),
    read(Nanswer),
    (   Nanswer =:= 2
    ->  print_prompt(bot), write('Bye'),nl,!, halt 
     ;   Nanswer =:= 1
    ->   print_prompt(bot), write("Please enter a fact on the list"),nl,
        write_ask_list,
        read_question(_F),!
    ;   write('Not a valid choice, try again...'), nl,fail
    ).



read_question(Fact):-
    repeat,
    print_prompt(user),
    read(N),
    node(N, Fact, _, _),
    %% LOUISE:  It's inelegant that this is repeated from the start, can you only do this once?
    %% LOUISE:  We are missing a cases for when the computer has responded to the user with a why not question.
    (  
    user_question(Fact),!
    ->  write("Computer: You have already asked this fact. Please enter a different fact."),nl,fail

    ;
        (deduce_backwards(Fact,node(_ID, Fact, _R, _DAG))
        -> print_prompt(bot),write(Fact), write(' is true.'), nl, ! ,
        read_agree, !,
        %% LOUISE: At this point the computer should add Fact to N_computer_user and Y_user_computer
        why_question(Fact),!
        ;                                 % legal move 4: some t ∈ Gi ∪ Nij the player may ask whynot(t)
        print_prompt(bot),write(Fact), write(' is false.'), nl,!,
        read_agree, !,
        %% LOUISE: At this point the computer should add Fact to Y_computer_user and N_user_computer
        whynot_question(Fact),!
       )
     ).

