%computer has a rule that user does not have 

user_fact(1, negative_pcr(may), initial_fact, []).
user_fact(2, negative_pcr(sarah), initial_fact, []).
user_fact(3,two_dose_v(may), initial_fact, []).
user_fact(4,two_dose_v(sarah), initial_fact, []).
user_fact(5,taste_and_smell(may), initial_fact, []).
user_fact(6,taste_and_smell(sarah), initial_fact, []).


user_rule(1,[not(taste_and_smell(X))], symptoms(X)).
user_rule(2,[fever(X)],symptoms(X)).
user_rule(3,[cough(X)],symptoms(X)).
user_rule(4, [negative_pcr(X)], pcr(X)).
user_rule(5, [pcr(X)], test(X)).
user_rule(6,[two_dose_v(X)], vaccinated(X)).
%user_rule(7,[vaccinated(X)], covid_pass(X)).
user_rule(7,[not(pinged(A)), not(pinged(B)), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B)),test(A),test(B)],can_meet(A, B)).
user_rule(8,[can_meet(X,Y),covid_pass(X),covid_pass(Y),negative_pcr(X),negative_pcr(Y)], go_to_spain(X,Y)).


conclusion(go_to_spain(may,sarah)).

node(1, negative_pcr(may), initial_fact, []).
node(2, negative_pcr(sarah), initial_fact, []).
node(3,two_dose_v(may), initial_fact, []).
node(4,two_dose_v(sarah), initial_fact, []).
node(5,taste_and_smell(may), initial_fact, []).
node(6,taste_and_smell(sarah), initial_fact, []).



rule(1,[not(taste_and_smell(X))], symptoms(X)).
rule(2,[fever(X)],symptoms(X)).
rule(3,[cough(X)],symptoms(X)).
rule(4,[negative_pcr(X)], pcr(X)).
rule(5,[pcr(X)], test(X)).
rule(6,[two_dose_v(X)], vaccinated(X)).
rule(7,[vaccinated(X)], covid_pass(X)).
rule(8,[not(pinged(A)), not(pinged(B)), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B)),test(A),test(B)],can_meet(A, B)).
rule(9,[can_meet(X,Y),covid_pass(X),covid_pass(Y),negative_pcr(X),negative_pcr(Y)], go_to_spain(X,Y)).

fact_description(two_dose_v(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," is vaccinated with two doses of any approved vaccine "),
    write(A), write(" is vaccinated with two doses of any approved vaccine ").
fact_description(test(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has taken a test"),
    write(X), write(" has taken a test").
fact_description(not(test(X))):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," hasn't take a test"),
    write(X), write(" hasn't take a test").
fact_description(pcr(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has a PCR test"),
     write(X), write(" has a PCR test").
fact_description(negative_pcr(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has a negative PCR test"),
     write(X), write(" has a negative PCR test").
fact_description(covid_pass(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," has NHS Covid pass"),
     write(A), write(" has NHS Covid pass").
fact_description(close_pcr_positive(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," has been in close contact with someone whose PCR test is positive. "),
     write(A), write(" has been in close contact with someone whose PCR test is positive. ").
fact_description(not(pinged(A))):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," has not been in close contact with someone who has Covid-19 "),
     write(A), write(" has not been in close contact with someone who has Covid-19 ").
fact_description(pinged(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," has been in close contact with someone who has Covid-19 "),
     write(A), write(" has been in close contact with someone who has Covid-19 ").
fact_description(vaccinated(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," is vaccinated"),
     write(A), write(" is vaccinated").
fact_description(taste_and_smell(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," have a sense of taste and smell"),
     write(X), write(" have  a sense of taste and smell").
fact_description(symptoms(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has symptoms"),
     write(X), write(" has symptoms").
fact_description(not(symptoms(X))):-
     nb_getval(fileOutput,Out),
     write(Out,X), write(Out," doesn't have any symptoms"),
     write(X), write(" doesn't have any symptoms").
fact_description(not(taste_and_smell(X))):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," doesn't have a sense of taste and smell"),
     write(X), write(" doesn't have  a sense of taste and smell").
fact_description(can_meet(A, B)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," and "), write(Out,B),write(Out," can meet"),
    write(A), write(" and "), write(B),write(" can meet").
fact_description(go_to_spain(A, B)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," and "), write(Out,B),write(Out," can go to Spain together"),
    write(A), write(" and "), write(B),write(" can go to Spain together").
fact_description(fever(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has fever"),
     write(X), write(" has fever").
fact_description(cough(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has cough"),
     write(X), write(" has cough").


rule_description(1):-
    nb_getval(fileOutput,Out),
    write(Out,"1. If X doesn't have taste or smell, then X has symptoms."),
    write("1. If X doesn't have taste or smell, then X has symptoms.").
rule_description(2):-
    nb_getval(fileOutput,Out),
    write(Out,"2. If X has a fever, then X has symptoms."),
    write("2. If X has a fever, then X has symptoms.").
rule_description(3):-
    nb_getval(fileOutput,Out),
    write(Out,"3. If X has a cough, then X has symptoms."),
    write("3. If X has a cough, then X has symptoms.").
rule_description(4):-
    nb_getval(fileOutput,Out),
    write(Out,"4. If A is negative in the PCRtest then A has taken a PCR test"),
    write("4. If A is negative in the PCR test then A has taken a PCR test").
rule_description(5):-
    nb_getval(fileOutput,Out),
    write(Out,"5. If A has a PCR test then A has taken a test"),
    write("5. If A has a PCR test then A has taken a test").
rule_description(6):-
    nb_getval(fileOutput,Out),
    write(Out,"6. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated."),
    write("6. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated.").
%rule_description(7):-
    %write("7. If X is vaccinated, then X has an NHS Covid pass."),nl.
rule_description(7):-
    nb_getval(fileOutput,Out),
    write(Out,"7. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, and both of them have a test, then A and B can meet."),
    write("7. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, and both of them have a test, then A and B can meet.").
rule_description(8):-
    nb_getval(fileOutput,Out),
    write(Out,"8. If A and B can meet and both of them have NHS Covid pass, and both of them have a negative PCR test, then A and B can go to Spain together."),
    write("8. If A and B can meet and both of them have NHS Covid pass, and both of them have a negative PCR test, then A and B can go to Spain together.").



r_description(1):-
    nb_getval(fileOutput,Out),
    write(Out,"1. If X doesn't have taste or smell, then X has symptoms."),
    write("1. If X doesn't have taste or smell, then X has symptoms."),nl.
r_description(2):-
    nb_getval(fileOutput,Out),
    write(Out,"2. If X has a fever, then X has symptoms."),
    write("2. If X has a fever, then X has symptoms."),nl.
r_description(3):-
    nb_getval(fileOutput,Out),
    write(Out,"3. If X has a cough, then X has symptoms."),
    write("3. If X has a cough, then X has symptoms."),nl.
r_description(4):-
    nb_getval(fileOutput,Out),
    write(Out,"4. If A is negative in the PCR test then A has taken a PCR test"),
    write("4. If A is negative in the  PCR test then A has taken a PCR test"),nl.
r_description(5):-
    nb_getval(fileOutput,Out),
    write(Out,"5. If A has a PCR test then A has taken a test"),
    write("5. If A has a PCR test then A has taken a test"),nl.
r_description(6):-
    nb_getval(fileOutput,Out),
    write(Out,"6. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated."),
    write("6. If X is vaccinated with two doses of any approved vaccine, then X is vaccinated."),nl.
r_description(7):-
    nb_getval(fileOutput,Out),
    write(Out,"7. If X is vaccinated, then X has an NHS Covid pass."),
    write("7. If X is vaccinated, then X has an NHS Covid pass."),nl.
r_description(8):-
    nb_getval(fileOutput,Out),
    write(Out,"8. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, and both of them have a test, then A and B can meet."),
    write("8. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, and both of them have a test, then A and B can meet."),nl.
r_description(9):-
    nb_getval(fileOutput,Out),
     write(Out,"9. If A and B can meet and both of them have NHS Covid pass, and both of them have a negative PCR test, then A and B can go to Spain together."),
    write("9. If A and B can meet and both of them have NHS Covid pass, and both of them have a negative PCR test, then A and B can go to Spain together."),nl.

system_rule(Rule):-
    r_description(Rule).
