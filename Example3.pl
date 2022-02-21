% similar rule but slightly different 
user_fact(1,pinged(jack),initial_fact,[]).
user_fact(2, vaccinated(jack), initial_fact, []).
user_fact(3, not_fever(jack), initial_fact, []).

user_rule(1, [fever(X)], symptoms(X)).
user_rule(2, [pinged(X), not(vaccinated(X)), not(symptoms(X))], get_pcr(X)).

initial_question(1,get_pcr(jack), "Does Jack need to take a pcr test?").


node(1,pinged(jack),initial_fact,[]).
node(2, vaccinated(jack), initial_fact, []).
node(3, not_fever(jack), initial_fact, []).

rule(1, [fever(X)], symptoms(X)).
rule(2, [pinged(X), vaccinated(X), not(pcr(X))], get_pcr(X)).

fact_description(pinged(A)):-
     write(A), write(" has been in close contact with someone who has Covid-19 ").
fact_description(vaccinated(A)):-
     write(A), write(" vaccinated").
fact_description(symptoms(X)):-
     write(X), write(" has symptoms").
fact_description(fever(X)):-
     write(X), write(" has fever").
fact_description(not_fever(X)):-
     write(X), write(" doesn't have fever").
fact_description(not(symptoms(X))):-
     write(X), write(" doesn't have any symptoms").
fact_description(not(pcr(X))):-
     write(X), write(" doesn't take a pcr test").
fact_description(get_pcr(X)):-
     write(X), write(" need to get a pcr test").
fact_description(pcr(X)):-
     write(X), write(" has a pcr test").


rule_description(1):-
    write("1. If someone has fever, he/she has symptoms."),nl.
rule_description(2):-
    write("2. If someone get close contact with a person with Covid and he/she hasn't been vaccinated, and he/she doesn't have symptoms, then he need to take a pcr test."),nl.


%% Pretty print the system rules 
r_description(1):-
   write("1. If someone has fever, he/she has symptoms."),nl.
r_description(2):-
  write("2. If someone get close contact with a person with Covid and he/she been vaccinated, and he/she hasn't taken pcr test, then he need to take a pcr test."),nl.

system_rule(Rule):-
    r_description(Rule).
