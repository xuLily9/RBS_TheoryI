% user has a fact and computer does not have

user_fact(1,vaccinated(harry), initial_fact, []).
user_fact(2,vaccinated(sara), initial_fact, []).
user_fact(3,taste_and_smell(sara), initial_fact, []).
user_fact(4,taste_and_smell(harry), initial_fact, []).

user_rule(1,[not(pinged(A)), not(pinged(B)), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B))],can_meet(A, B)).
user_rule(2,[not(taste_and_smell(X))], symptoms(X)).
user_rule(3,[fever(X)],symptoms(X)).
user_rule(4,[cough(X)],symptoms(X)).

%initial_question(1,can_meet(sara, harry), "Can Sara and harry meet?").
conclusion(can_meet(sara, harry)).


node(1,vaccinated(sara), initial_fact, []).
node(2,taste_and_smell(sara), initial_fact, []).
node(3,taste_and_smell(harry), initial_fact, []).

rule(1,[not(pinged(A)), not(pinged(B)), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B))],can_meet(A, B)).
rule(2,[not(taste_and_smell(X))], symptoms(X)).
rule(3,[fever(X)],symptoms(X)).
rule(4,[cough(X)],symptoms(X)).



fact_description(not(pinged(A))):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' has not been in close contact with someone who has Covid-19'),
    write(A), write(" has not been in close contact with someone who has Covid-19 ").
fact_description(pinged(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' has been in close contact with someone who has Covid-19' ),
    write(A), write(" has been in close contact with someone who has Covid-19 ").
fact_description(vaccinated(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' is vaccinated'),
    write(A), write(" is vaccinated").
fact_description(taste_and_smell(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' has the taste and smell'),
    write(X), write(" has the taste and smell").
fact_description(symptoms(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' has symptoms'),
    write(X), write(" has symptoms").
fact_description(not(symptoms(X))):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' does not have any symptoms'),
    write(X), write(" doesn't have any symptoms").
fact_description(not(taste_and_smell(X))):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' does not have taste and smell'),
    write(X), write(" doesn't have taste and smell").
fact_description(can_meet(A, B)):-
    write(A), write(" and "), write(B),write(" can meet"),
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' and ' ), write(Out, B),write(Out,' can meet').
fact_description(fever(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' has fever'),
    write(X), write(" has fever").
fact_description(cough(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' has cough'),
    write(X), write(" has cough"

rule_description(1):-
    write("1. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, then A and B can meet."),
    nb_getval(fileOutput,Out),
    write(Out, "1. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, then A and B can meet.").
rule_description(2):-
    write("2. If X doesn't have taste or smell, then X has symptoms."),
    nb_getval(fileOutput,Out),
    write(Out,"2. If X doesn't have taste or smell, then X has symptoms.").
rule_description(3):-
    write("3. If X has a fever, then X has symptoms."),
    nb_getval(fileOutput,Out),
    write(Out,"3. If X has a fever, then X has symptoms.").
rule_description(4):-
    nb_getval(fileOutput,Out),
    write("4. If X has a cough, then X has symptoms."),
    nb_getval(fileOutput,Out),
    write(Out,"4. If X has a cough, then X has symptoms.").

%% Pretty print the system rules 
r_description(1):-
    nb_getval(fileOutput,Out),
    write(Out, "1. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, then A and B can meet."),
    write("1. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, then A and B can meet."),nl.
r_description(2):-
    nb_getval(fileOutput,Out),
    write(Out, "2. If X doesn't have taste or smell, then X has symptoms."),
    write("2. If X doesn't have taste or smell, then X has symptoms."),nl.
r_description(3):-
    nb_getval(fileOutput,Out),
    write(Out, "3. If X has a fever, then X has symptoms."),
    write("3. If X has a fever, then X has symptoms."),nl.
r_description(4):-
    nb_getval(fileOutput,Out),
    write(Out, "4. If X has a cough, then X has symptoms."),
    write("4. If X has a cough, then X has symptoms."),nl.
system_rule(Rule):-
    r_description(Rule).

