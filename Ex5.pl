% computer does not have a fact but user has(conclusion is true)

user_fact(1, meet_at_uni(may,lewis),initial_fact,[]).
user_fact(2, vaccinated(may), initial_fact, []).
user_fact(3, positive_pcr(lewis), initial_fact, []).
user_fact(4, taste_and_smell(may),initial_fact,[]).
user_fact(5, negative_pcr(may),initial_fact,[]).

user_rule(1, [pinged(X), vaccinated(X), not(test(X))], self_isolate(X)).
user_rule(2, [positive_pcr(Y),meet_at_uni(X,Y)], pinged(X)).
user_rule(3, [not(taste_and_smell(X))], symptoms(X)).
user_rule(4, [negative_pcr(X)], test(X)).


conclusion(self_isolate(may)).


node(1, meet_at_uni(may,lewis),initial_fact,[]).
node(2, vaccinated(may), initial_fact, []).
node(3, positive_pcr(lewis), initial_fact, []).
node(4, taste_and_smell(may),initial_fact,[]).


rule(1, [pinged(X), vaccinated(X), not(test(X))], self_isolate(X)).
rule(2, [positive_pcr(Y),meet_at_uni(X,Y)], pinged(X)).
rule(3, [not(taste_and_smell(X))], symptoms(X)).
rule(4, [negative_pcr(X)], test(X)).


fact_description(negative_pcr(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' is negative in the PCR test'),
     write(X), write(' is negative in the PCR test').
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
fact_description(taste_and_smell(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' have a sense of taste and smell'),
     write(X), write(' have  a sense of taste and smell').
fact_description(symptoms(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' has symptoms'),
     write(X), write(' has symptoms').
fact_description(not(symptoms(X))):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' does not have any symptoms'),
     write(X), write(' does not have any symptoms').
fact_description(not(taste_and_smell(X))):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' does not have a sense of taste and smell'),
     write(X), write(' does not have  a sense of taste and smell').
fact_description(meet_at_uni(A, B)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' and '), write(Out,B),write(Out,' meet at the university.'),
    write(A), write(' and '), write(B),write(' meet at the university.').
fact_description(not(test(X))):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' has not take a test'),
     write(X), write(' has not take a test').
fact_description(self_isolate(X)):-
     nb_getval(fileOutput,Out),
     write(X), write(' need to self isolate'),
     write(Out,X), write(Out,' need to self isolate').
fact_description(test(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out,' has taken a test'),
     write(X), write(' has taken a test').


rule_description(1):-
     nb_getval(fileOutput,Out),
     write(Out,'1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she has not taken a test, then he/she need to self-isolate'),
     write('1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she has not taken a test, then he/she need to self-isolate').
rule_description(2):-
     nb_getval(fileOutput,Out),
     write(Out,'2. If A is positive in the PCR test and A and B meet at the university, then B has been in close contact with someone who has Covid-19'),
     write('2. If A is positive in the PCR test and A and B meet at the university, then B has been in close contact with someone who has Covid-19').
rule_description(3):-
    nb_getval(fileOutput,Out),
    write(Out,'3. If X does not have taste or smell, then X has symptoms.'),
    write('3. If X does not have taste or smell, then X has symptoms.').
rule_description(4):-
     nb_getval(fileOutput,Out),
     write(Out,'4. If A is negative in the PCR test then A has taken a test'),
     write('4. If A is negative in the PCR test then A has taken a test').



%% Pretty print the system rules 
r_description(1):-
     nb_getval(fileOutput,Out),
     write(Out,'1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she has not taken a test, then he/she need to self-isolate'),
     write('1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she has not taken a test, then he/she need to self-isolate').
r_description(2):-
     nb_getval(fileOutput,Out),
     write(Out,'2. If A is positive in the PCR test and A and B meet at the university, then B has been in close contact with someone who has Covid-19'),
     write('2. If A is positive in the PCR test and A and B meet at the university, then B has been in close contact with someone who has Covid-19').
r_description(3):-
    nb_getval(fileOutput,Out),
    write(Out,'3. If X does not have taste or smell, then X has symptoms.'),
    write('3. If X does not have taste or smell, then X has symptoms.').
r_description(4):-
     nb_getval(fileOutput,Out),
     write(Out,'4. If A is negative in the PCR test then A has taken a test'),
     write('4. If A is negative in the PCR test then A has taken a test').

system_rule(Rule):-
    r_description(Rule).