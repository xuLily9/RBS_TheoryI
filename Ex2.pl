



user_fact(1,two_dose_v(harry), initial_fact, []).
user_fact(2,two_dose_v(ella), initial_fact, []).
user_fact(3,taste_and_smell(harry), initial_fact, []).
user_fact(4,taste_and_smell(ella), initial_fact, []).
user_fact(5,wear_mask(harry), initial_fact, []).

user_rule(1,[not(pinged(A)), not(pinged(B)), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B))],can_meet(A, B)).
user_rule(2,[not(taste_and_smell(X))], symptoms(X)).
user_rule(3,[fever(X)],symptoms(X)).
user_rule(4,[cough(X)],symptoms(X)).
user_rule(5,[close_pcr_positive(X)], pinged(X)).
user_rule(6,[vaccinated(X)], covid_pass(X)).
user_rule(7,[can_meet(X,Y),covid_pass(X),covid_pass(Y),wear_mask(X),wear_mask(Y)], watch_football(X,Y)).
user_rule(8,[two_dose_v(X)], vaccinated(X)).

initial_question(1,watch_football(ella, harry), "Can Ella and harry watch football together?").



node(1,two_dose_v(harry), initial_fact, []).
node(2,two_dose_v(ella), initial_fact, []).
node(3,taste_and_smell(ella), initial_fact, []).
node(4,taste_and_smell(harry), initial_fact, []).
node(5,wear_mask(harry), initial_fact, []).
node(6,wear_mask(ella), initial_fact, []).

rule(1,[not(pinged(A)), not(pinged(B)), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B))],can_meet(A, B)).
rule(2,[not(taste_and_smell(X))], symptoms(X)).
rule(3,[fever(X)],symptoms(X)).
rule(4,[cough(X)],symptoms(X)).
rule(5,[close_pcr_positive(X)], pinged(X)).
rule(6,[vaccinated(X)], covid_pass(X)).
rule(7,[can_meet(X,Y),covid_pass(X),covid_pass(Y),wear_mask(X),wear_mask(Y)], watch_football(X,Y)).
rule(8,[two_dose_v(X)], vaccinated(X)).

fact_description(two_dose_v(A)):-
     write(A), write(" is vaccinated with two doses of any approved vaccine ").
fact_description(wear_mask(A)):-
     write(A), write(" wears the mask").
fact_description(covid_pass(A)):-
     write(A), write(" has NHS Covid pass").
fact_description(close_pcr_positive(A)):-
     write(A), write(" has been in close contact with someone whose pcr test is positive. ").
fact_description(not(pinged(A))):-
     write(A), write(" has not been in close contact with someone who has Covid-19 ").
fact_description(pinged(A)):-
     write(A), write(" has been in close contact with someone who has Covid-19 ").
fact_description(vaccinated(A)):-
     write(A), write(" is vaccinated").
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
fact_description(watch_football(A, B)):-
    write(A), write(" and "), write(B),write(" can watch football together").
fact_description(fever(X)):-
     write(X), write(" has fever").
fact_description(cough(X)):-
     write(X), write(" has cough").




rule_description(1):-
    write("1. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, then A and B can meet."),nl.
rule_description(2):-
    write("2. If X doesn't have taste or smell, then X has symptoms."),nl.
rule_description(3):-
    write("3. If X has a fever, then X has symptoms."),nl.
rule_description(4):-
    write("4. If X has a cough, then X has symptoms."),nl.
rule_description(5):-
    write("5. If X has been in close contact with someone whose pcr test is positive, then X is pinged"),nl.
rule_description(6):-
    write("6. If X is vaccinated, then X has an NHS Covid pass."),nl.
rule_description(7):-
    write("7. If A and B can meet and both of them have NHS Covid pass, and both of them wear masks, then A and B can watch football together."),nl.
rule_description(8):-
    write("8. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated."),nl.

%% Pretty print the system rules 
r_description(1):-
   write("1. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, then A and B can meet."),nl.
r_description(2):-
   write("2. If X doesn't have taste or smell, then X has symptoms."),nl.
r_description(3):-
    write("3. If X has a fever, then X has symptoms."),nl.
r_description(4):-
    write("4. If X has a cough, then X has symptoms."),nl.
r_description(5):-
    write("5. If X has been in close contact with someone whose pcr test is positive, then X is pinged"),nl.
r_description(6):-
    write("6. If X is vaccinated, then X has an NHS Covid pass."),nl.
r_description(7):-
    write("7. If A and B can meet and both of them have NHS Covid pass, and both of them wear masks, then A and B can watch football together."),nl.
r_description(8):-
    write("8. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated."),nl.
system_rule(Rule):-
    r_description(Rule).