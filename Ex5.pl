% user has a rule and computer does not have

user_fact(1,pinged(may),initial_fact,[]).
user_fact(2, vaccinated(may), initial_fact, []).
user_fact(3, negative_pcr(may), initial_fact, []).


user_rule(1, [pinged(X), vaccinated(X), not(test(X))], self_isolate(X)).
user_rule(2, [negative_pcr(X)], pcr(X)).
user_rule(3, [pcr(X)], test(X)).


conclusion(self_isolate(may)).


node(1,pinged(may),initial_fact,[]).
node(2, vaccinated(may), initial_fact, []).
node(3, negative_pcr(may), initial_fact, []).


rule(1, [pinged(X), vaccinated(X), not(test(X))], self_isolate(X)).
%rule(2, [negative_pcr(X)], pcr(X)).
rule(2, [pcr(X)], test(X)).


fact_description(negative_pcr(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," is negative in the PCR test"),
     write(X), write(" is negative in the PCR test").
fact_description(pinged(A)):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out," has been in close contact with someone who has Covid-19 "),
     write(A), write(" has been in close contact with someone who has Covid-19 ").
fact_description(vaccinated(A)):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out," vaccinated"),
     write(A), write(" vaccinated").
fact_description(pcr(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," has a pcr test"),
     write(X), write(" has a pcr test").
fact_description(not(test(X))):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," hasn't take a test"),
     write(X), write(" hasn't take a test").
fact_description(self_isolate(X)):-
     nb_getval(fileOutput,Out),
     write(X), write(" need to self isolate"),
     write(Out,X), write(Out," need to self isolate").
fact_description(test(X)):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," has taken a test"),
     write(X), write(" has taken a test").


rule_description(1):-
     nb_getval(fileOutput,Out),
     write(Out,"1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she hasn't taken a test, then he/she need to self-isolate"),
     write("1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she hasn't taken a test, then he/she need to self-isolate").
rule_description(2):-
     nb_getval(fileOutput,Out),
     write(Out,"2. If A is negative in the PCR test then A has taken a PCR test"),
     write("2. If A is negative in the PCR test then A has taken a PCR test").
rule_description(3):-
     nb_getval(fileOutput,Out),
     write(Out,"3. If A has a PCR test then A has taken a test"),
     write("3. If A has a PCR test then A has taken a test").



%% Pretty print the system rules 
r_description(1):-
     nb_getval(fileOutput,Out),
     write(Out,"1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she hasn't taken a test, then he/she need to self-isolate"),
     write("1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she hasn't taken a test, then he/she need to self-isolate"),nl.
r_description(2):-
     nb_getval(fileOutput,Out),
     write(Out,"2. If A has a PCR test then A has taken a test"),
     write("2. If A has a PCR test then A has taken a test"),nl.

system_rule(Rule):-
    r_description(Rule).