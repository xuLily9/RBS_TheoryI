% similar rule but slightly different 
user_fact(1, vaccinated(jack), initial_fact, []).
user_fact(2, fever(jack), initial_fact, []).
user_fact(3, positive_pcr(harry),initial_fact,[]).
user_fact(4, eat_dinner(harry,jack),initial_fact,[]).

user_rule(1, [fever(X)], symptoms(X)).
user_rule(2, [pinged(X),not(vaccinated(X))], get_pcr(X)).
user_rule(3, [positive_pcr(Y), eat_dinner(X,Y)], pinged(X)).

conclusion(get_pcr(jack)).


node(1, vaccinated(jack), initial_fact, []).
node(2, fever(jack), initial_fact, []).
node(3, positive_pcr(harry),initial_fact,[]).
node(4, eat_dinner(harry,jack),initial_fact,[]).

rule(1, [fever(X)], symptoms(X)).
rule(2, [symptoms(X),pinged(X)], get_pcr(X)).
rule(3, [positive_pcr(Y), eat_dinner(Y,X)], pinged(X)).

fact_description(positive_pcr(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' is positive in the PCR test'),
     write(X), write(' is positive in the PCR test').
fact_description(pinged(A)):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out,' has been in close contact with someone who has Covid-19 '),
     write(A), write(' has been in close contact with someone who has Covid-19 ').
fact_description(vaccinated(A)):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out,' vaccinated'),
     write(A), write(' vaccinated').
fact_description(symptoms(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' has symptoms'),
     write(X), write(' has symptoms').
fact_description(fever(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' has fever'),
     write(X), write(' has fever').
fact_description(vaccinated(A)):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out,' vaccinated'),
     write(A), write(' vaccinated').
fact_description(not(vaccinated(A))):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out,' has not vaccinated'),
     write(A), write(' has not vaccinated').
fact_description(not(symptoms(X))):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' does nothave any symptoms'),
     write(X), write(' does nothave any symptoms').
fact_description(not(pcr(X))):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' does nottake a PCR test'),
     write(X), write(' does nottake a PCR test').
fact_description(get_pcr(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' need to get a PCR test'),
     write(X), write(' need to get a PCR test').
fact_description(eat_dinner(A, B)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' and '), write(Out,B),write(Out,' eat dinner together.'),
    write(A), write(' and '), write(B),write(' eat dinner together.').


rule_description(1):-
     nb_getval(fileOutput,Out),
     write(Out,'1. If someone has a fever, he/she has symptoms.'),
     write('1. If someone has a fever, he/she has symptoms.').
rule_description(2):-
     nb_getval(fileOutput,Out),
     write(Out,'2. If someone gets close contact with a person with Covid and he/she has not been vaccinated, then he needs to take a pcr test.'),
     write('2. If someone gets close contact with a person with Covid and he/she has not been vaccinated, then he needs to take a pcr test.').
rule_description(3):-
     nb_getval(fileOutput,Out),
     write(Out,'3. If A is positive in the PCR test and A and B eat dinner together, then B has been in close contact with someone who has Covid-19.'),
     write('3. If A is positive in the PCR test and A and B eat dinner together, then B has been in close contact with someone who has Covid-19.').


%% Pretty print the system rules 
r_description(1):-
     nb_getval(fileOutput,Out),
     write(Out,'1. If someone has a fever, he/she has symptoms.'),
     write('1. If someone has a fever, he/she has symptoms.'),nl.
r_description(2):-
     nb_getval(fileOutput,Out),
     write(Out,'2. If someone has symptoms and has been close contact with a person with Covid, then he needs to take a pcr test.'),
     write('2. If someone someone has symptoms and has been close contact with a person with Covid, then he needs to take a pcr test.'),nl.
r_description(3):-
     nb_getval(fileOutput,Out),
     write(Out,'3. If A is positive in the PCR test and A and B eat dinner together, then B has been in close contact with someone who has Covid-19.'),
     write('3. If A is positive in the PCR test and A and B eat dinner together, then B has been in close contact with someone who has Covid-19.').

system_rule(Rule):-
    r_description(Rule).
