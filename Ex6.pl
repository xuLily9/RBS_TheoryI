% similar rule but slightly different 
user_fact(1,pinged(jack),initial_fact,[]).
user_fact(2, vaccinated(jack), initial_fact, []).
user_fact(3, not_fever(jack), initial_fact, []).

user_rule(1, [fever(X)], symptoms(X)).
user_rule(2, [pinged(X), not(vaccinated(X)), not(symptoms(X))], get_pcr(X)).

conclusion(get_pcr(jack)).


node(1,pinged(jack),initial_fact,[]).
node(2, vaccinated(jack), initial_fact, []).
node(3, not_fever(jack), initial_fact, []).

rule(1, [fever(X)], symptoms(X)).
rule(2, [pinged(X), vaccinated(X), not(pcr(X))], get_pcr(X)).

fact_description(pinged(A)):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out," has been in close contact with someone who has Covid-19 "),
     write(A), write(" has been in close contact with someone who has Covid-19 ").
fact_description(vaccinated(A)):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out," vaccinated"),
     write(A), write(" vaccinated").
fact_description(symptoms(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," has symptoms"),
     write(X), write(" has symptoms").
fact_description(fever(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," has fever"),
     write(X), write(" has fever").
fact_description(not_fever(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," doesn't have fever"),
     write(X), write(" doesn't have fever").
fact_description(not(symptoms(X))):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," doesn't have any symptoms"),
     write(X), write(" doesn't have any symptoms").
fact_description(not(pcr(X))):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," doesn't take a PCR test"),
     write(X), write(" doesn't take a PCR test").
fact_description(get_pcr(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," need to get a PCR test"),
     write(X), write(" need to get a PCR test").
fact_description(pcr(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," has a PCR test"),
     write(X), write(" has a PCR test").


rule_description(1):-
     nb_getval(fileOutput,Out),
      write(Out,"1. If someone has a fever, he/she has symptoms."),
     write("1. If someone has a fever, he/she has symptoms.").
rule_description(2):-
     nb_getval(fileOutput,Out),
     write(Out,"2. If someone gets close contact with a person with Covid and he/she hasn't been vaccinated, and he/she doesn't have symptoms, then he needs to take a pcr test."),
     write("2. If someone gets close contact with a person with Covid and he/she hasn't been vaccinated, and he/she doesn't have symptoms, then he needs to take a pcr test.").


%% Pretty print the system rules 
r_description(1):-
     nb_getval(fileOutput,Out),
     write(Out,"1. If someone has a fever, he/she has symptoms."),
     write("1. If someone has a fever, he/she has symptoms."),nl.
r_description(2):-
     nb_getval(fileOutput,Out),
     write(Out,"2. If someone gets close contact with a person with Covid and he/she has been vaccinated, and he/she hasn't taken a pcr test, then he needs to take a pcr test."),
     write("2. If someone gets close contact with a person with Covid and he/she has been vaccinated, and he/she hasn't taken a pcr test, then he needs to take a pcr test."),nl.

system_rule(Rule):-
    r_description(Rule).
