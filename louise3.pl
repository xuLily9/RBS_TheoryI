:-dynamic node/4, rule/3.

node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).
node(4, taste_and_smell(mary), initial_fact, []).
node(5, taste_and_smell(karl), initial_fact, []).


rule(1, [residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B), not(symptoms(X)), not(symptoms(A))],can_meet_indoors(X, A)).
rule(2, [tier1(X)], indoor_meetings_allowed(X)).
rule(3, [cough(X)], symptoms(X)).
rule(4, [fever(X)], symptoms(X)).
rule(5, [not(taste_and_smell(X))], symptoms(X)).

initial_question(1,can_meet_indoors(mary, karl), "Can Mary and Karl meet indoors?").



%% A set of user facts and rules 
user_fact(1,residence(mary, manchester),initial_fact,[]).
user_fact(2,residence(karl, manchester),initial_fact,[]).
user_fact(3,tier1(manchester),initial_fact,[]).
user_fact(4, taste_and_smell(mary), initial_fact, []).
%% user does not know karl have symptoms or not

user_rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B), not(symptoms(X)), not(symptoms(A))],can_meet_indoors(X, A)).
user_rule(2,[tier1(X)], indoor_meetings_allowed(X)).
user_rule(3, [cough(X)], symptoms(X)).
user_rule(4, [fever(X)], symptoms(X)).
user_rule(5, [not(taste_and_smell(X))], symptoms(X)).




fact_description(residence(X,Y)):-
     write(X), write(" lives in "), write(Y).

fact_description(tier1(X)):-
     write(X), write(" is in tier1").

fact_description(indoor_meetings_allowed(Y)):-
     write(Y), write(" allows indoor meetings").

fact_description(can_meet_indoors(X, A)):-
    write(X), write(" and "), write(A),write(" can meet indoors").


fact_description(cough(X)):-
     write(X), write(" has cough").

fact_description(fever(X)):-
     write(X), write(" has fever").

fact_description(taste_and_smell(X)):-
     write(X), write(" have taste and smell").

fact_description(not(symptoms(X))):-
     write(X), write(" doesn't have any symptoms").


rule_description(1):-
    write("1. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings and both of them don't have any symptoms, then these two people can meet indoors."),nl.

rule_description(2):-
    write("2. If there is a city in tier1 then this city allow indoor meetings."),nl.

rule_description(3):-
    write("3. If someone has cough, he/she has symptoms."),nl.

rule_description(4):-
    write("4. If someone has fever, he/she has symptoms."),nl.

rule_description(5):-
    write("5. If someone doesn't have taste or smell, he/she has symptoms."),nl.
