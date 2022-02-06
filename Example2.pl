% user has a rule and computer does not have

user_fact(1,pinged(may),initial_fact,[]).
user_fact(2, vaccinated(may), initial_fact, []).
user_fact(3, negative_pcr(may), initial_fact, []).


user_rule(1, [pinged(X), vaccinated(X), not(test(X))], self_isolate(X)).
user_rule(2, [negative_pcr(X)], pcr(X)).
user_rule(3, [pcr(X)], test(X)).


initial_question(1,self_isolate(may), "Does may need to self isolate?").


node(1,pinged(may),initial_fact,[]).
node(2, vaccinated(may), initial_fact, []).
node(3, negative_pcr(may), initial_fact, []).


rule(1, [pinged(X), vaccinated(X), not(test(X))], self_isolate(X)).
%rule(2, [negative_pcr(X)], pcr(X)).
rule(2, [pcr(X)], test(X)).


fact_description(negative_pcr(X)):-
     write(X), write(" is negative in pcr test").
fact_description(pinged(A)):-
     write(A), write(" has been in close contact with someone who has Covid-19 ").
fact_description(vaccinated(A)):-
     write(A), write(" vaccinated").
fact_description(pcr(X)):-
     write(X), write(" has a pcr test").
fact_description(not(test(X))):-
     write(X), write(" hasn't take a test").
fact_description(self_isolate(X)):-
     write(X), write(" need to self isolate").
fact_description(test(X)):-
     write(X), write(" has taken a test").


rule_description(1):-
    write("1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she hasn't take a test, then he/she need to self isolated"),nl.
rule_description(2):-
    write("2. If A is negative in pcr test then A has taken a pcr test"),nl.
rule_description(3):-
    write("3. If A has a pcr test then A has taken a test"),nl.



%% Pretty print the system rules 
r_description(1):-
    write("1. If A has been in close contact with someone who has Covid-19, and he/she is vaccinated, and he/she hasn't take a test, then he/she need to self isolated"),nl.
r_description(2):-
     write("2. If A has a pcr test then A has taken a test"),nl.

system_rule(Rule):-
    r_description(Rule).