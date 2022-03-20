/* computer has a fact but user does not have*/

user_fact(1,two_dose_v(harry), initial_fact, []).
user_fact(2,two_dose_v(ella), initial_fact, []).
user_fact(3,taste_and_smell(harry), initial_fact, []).
user_fact(4,taste_and_smell(ella), initial_fact, []).
user_fact(5,wear_mask(harry), initial_fact, []).

user_rule(1,[not(pinged(A)), vaccinated(A), not(symptoms(A))],meet_friends(A)).
user_rule(2,[not(taste_and_smell(X))], symptoms(X)).
user_rule(3,[fever(X)],symptoms(X)).
user_rule(4,[cough(X)],symptoms(X)).
user_rule(5,[close_pcr_positive(X)], pinged(X)).
user_rule(6,[vaccinated(X)], covid_pass(X)).
user_rule(7,[meet_friends(X),meet_friends(Y),covid_pass(X),covid_pass(Y),wear_mask(X),wear_mask(Y)], watch_football(X,Y)).
user_rule(8,[two_dose_v(X)], vaccinated(X)).

conclusion(watch_football(ella, harry)).

node(1,two_dose_v(harry), initial_fact, []).
node(2,two_dose_v(ella), initial_fact, []).
node(3,taste_and_smell(ella), initial_fact, []).
node(4,taste_and_smell(harry), initial_fact, []).
node(5,wear_mask(harry), initial_fact, []).
node(6,wear_mask(ella), initial_fact, []).

rule(1,[not(pinged(A)), vaccinated(A), not(symptoms(A))],meet_friends(A)).
rule(2,[not(taste_and_smell(X))], symptoms(X)).
rule(3,[fever(X)],symptoms(X)).
rule(4,[cough(X)],symptoms(X)).
rule(5,[close_pcr_positive(X)], pinged(X)).
rule(6,[vaccinated(X)], covid_pass(X)).
rule(7,[meet_friends(X),meet_friends(Y),covid_pass(X),covid_pass(Y),wear_mask(X),wear_mask(Y)], watch_football(X,Y)).
rule(8,[two_dose_v(X)], vaccinated(X)).

fact_description(two_dose_v(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' is vaccinated with two doses of any approved vaccine'),
     write(A), write(' is vaccinated with two doses of any approved vaccine').
fact_description(wear_mask(A)):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out,' wears the mask'),
     write(A), write(' wears the mask').
fact_description(covid_pass(A)):-
     nb_getval(fileOutput,Out),
     write(Out,A), write(Out,' has NHS Covid pass'),
     write(A), write(' has NHS Covid pass').
fact_description(close_pcr_positive(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' has been in close contact with someone whose PCR test is positive'),
    write(A), write(' has been in close contact with someone whose PCR test is positive').
fact_description(not(pinged(A))):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' has not been in close contact with someone who has Covid-19'),
    write(A), write(' has not been in close contact with someone who has Covid-19').
fact_description(pinged(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' has been in close contact with someone who has Covid-19'),
    write(A), write(' has been in close contact with someone who has Covid-19').
fact_description(vaccinated(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' is vaccinated'),
    write(A), write(' is vaccinated').
fact_description(taste_and_smell(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' has taste and smell'),
    write(X), write(' has taste and smell').
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
    write(Out,X), write(Out,' does not have taste and smell'),
    write(X), write(' does not have taste and smell').
fact_description(meet_friends(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' can meet friends'),
    write(A),write(' can meet friends').
fact_description(watch_football(A, B)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out,' and '), write(Out,B),write(Out,' can watch football in the stadium together'),
    write(A), write(' and '), write(B),write(' can watch football in the stadium together').
fact_description(fever(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' has fever'),
    write(X), write(' has fever').
fact_description(cough(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out,' has cough'),
    write(X), write(' has cough').




rule_description(1):-
    nb_getval(fileOutput,Out),
    write(Out, '1. If both A is vaccinated, and he/she does not have been pinged(close contact with someone who has Covid-19), and he/she does not have symptoms, then A can meet friends.'),
    write('1. If both A is vaccinated, and he/she does not have been pinged(close contact with someone who has Covid-19), and he/she does not have symptoms, then A can meet friends.').
rule_description(2):-
    nb_getval(fileOutput,Out),
    write(Out, '2. If X does not have taste or smell, then X has symptoms.'),
    write('2. If X does not have taste or smell, then X has symptoms.').
rule_description(3):-
    nb_getval(fileOutput,Out),
    write(Out, '3. If X has a fever, then X has symptoms.'),
    write('3. If X has a fever, then X has symptoms.').
rule_description(4):-
    nb_getval(fileOutput,Out),
    write(Out,'4. If X has a cough, then X has symptoms.'),
    write('4. If X has a cough, then X has symptoms.').
rule_description(5):-
    nb_getval(fileOutput,Out),
    write(Out, '5. If X has been in close contact with someone whose PCR test is positive, then X is pinged'),
    write('5. If X has been in close contact with someone whose PCR test is positive, then X is pinged').
rule_description(6):-
    nb_getval(fileOutput,Out),
    write(Out,'6. If X is vaccinated, then X has an NHS Covid pass.'),
    write('6. If X is vaccinated, then X has an NHS Covid pass.').
rule_description(7):-
    nb_getval(fileOutput,Out),
    write(Out,'7. If A can meet firends and B can meet friends and both of them have NHS Covid pass, and both of them wear masks, then A and B can watch football in the stadium together'),
    write('7. If A can meet firends and B can meet friends and both of them have NHS Covid pass, and both of them wear masks, then A and B can watch football in the stadium together').
rule_description(8):-
    nb_getval(fileOutput,Out),
    write(Out, '8. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated.'),
    write('8. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated.').

%% Pretty print the system rules 
r_description(1):-
    nb_getval(fileOutput,Out),
    write(Out, '1. If both A is vaccinated, and he/she does not have been pinged(close contact with someone who has Covid-19), and he/she does not have symptoms, then A can meet friends.'),
    write('1. If both A is vaccinated, and he/she does not have been pinged(close contact with someone who has Covid-19), and he/she does not have symptoms, then A can meet friends.'),nl.
r_description(2):-
    nb_getval(fileOutput,Out),
    write(Out,'2. If X does not have taste or smell, then X has symptoms.'),
    write('2. If X does not have taste or smell, then X has symptoms.'),nl.
r_description(3):-
    nb_getval(fileOutput,Out),
    write(Out,'3. If X has a fever, then X has symptoms.'),
    write('3. If X has a fever, then X has symptoms.'),nl.
r_description(4):-
    nb_getval(fileOutput,Out),
    write(Out, '4. If X has a cough, then X has symptoms.'),
    write('4. If X has a cough, then X has symptoms.'),nl.
r_description(5):-
    nb_getval(fileOutput,Out),
    write(Out,'5. If X has been in close contact with someone whose PCR test is positive, then X is pinged'),
    write('5. If X has been in close contact with someone whose PCR test is positive, then X is pinged'),nl.
r_description(6):-
    nb_getval(fileOutput,Out),
    write(Out,'6. If X is vaccinated, then X has an NHS Covid pass.'),
    write('6. If X is vaccinated, then X has an NHS Covid pass.'),nl.
r_description(7):-
    nb_getval(fileOutput,Out),
    write(Out,'7. If A can meet firends and B can meet friends and both of them have NHS Covid pass, and both of them wear masks, then A and B can watch football in stadium together.'),
    write('7. If A can meet firends and B can meet friends can meet and both of them have NHS Covid pass, and both of them wear masks, then A and B can watch football in stadium together.'),nl.
r_description(8):-
    nb_getval(fileOutput,Out),
    write(Out,'8. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated.'),
    write('8. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated.'),nl.
system_rule(Rule):-
    r_description(Rule).