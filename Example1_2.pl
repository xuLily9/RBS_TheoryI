% user has a fact and computer does not have

user_fact(1,not_pinged(ella),initial_fact,[]).
user_fact(2,not_pinged(harry),initial_fact,[]).
user_fact(3,vaccinated(harry), initial_fact, []).
user_fact(4,vaccinated(ella), initial_fact, []).
user_fact(5,taste_and_smell(harry), initial_fact, []).

user_rule(1,[not_pinged(A), not_pinged(B), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B))],can_meet(A, B)).
user_rule(2,[taste_and_smell(X)], not(symptoms(X))).


initial_question(1,can_meet(ella, harry), "Can Ella and harry meet?").


node(1,not_pinged(ella),initial_fact,[]).
node(2,not_pinged(harry),initial_fact,[]).
node(2,vaccinated(harry), initial_fact, []).
node(3,vaccinated(ella), initial_fact, []).
node(4,taste_and_smell(ella), initial_fact, []).
node(5,taste_and_smell(harry), initial_fact, []).

rule(1,[not_pinged(A), not_pinged(B), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B))],can_meet(A, B)).
rule(2,[taste_and_smell(X)], not(symptoms(X))).



fact_description(not_pinged(A)):-
     write(A), write(" has not been in close contact with someone who has Covid-19 ").
fact_description(pinged(A)):-
     write(A), write(" has been in close contact with someone who has Covid-19 ").
fact_description(vaccinated(A)):-
     write(A), write(" vaccinated").
fact_description(taste_and_smell(X)):-
     write(X), write(" have taste and smell").
fact_description(symptoms(X)):-
     write(X), write(" has symptoms").
fact_description(not(symptoms(X))):-
     write(X), write(" doesn't have any symptoms").
fact_description(not(taste_and_smell(X))):-
     write(X), write(" doesn't have taste and smell").
fact_description(can_meet(A, B)):-
    write(A), write(" and "), write(B),write(" can meet").





rule_description(1):-
    write("1. If both A and B are vaccinated, and none of them have been in close contact with someone who has Covid-19, and both of them don't have symptoms, then these two people can meet."),nl.
rule_description(2):-
    write("2. If A doesn't have taste or smell, he/she has symptoms."),nl.


%% Pretty print the system rules 
r_description(1):-
   write("1. If both A and B are vaccinated, and none of them have been in close contact with someone who has Covid-19, and both of them doesn't have symptoms, then these two people can meet."),nl.
r_description(2):-
   write("2. If A doesn't have taste or smell, he/she has symptoms."),nl.

system_rule(Rule):-
    r_description(Rule).