
node(1, two_dose_v(jane), initial_fact, []).
node(2, two_dose_v(adam), initial_fact, []).
node(3, negative_lft(jane),initial_fact, []).
node(4, negative_pcr(adam), initial_fact, []).

node(5, residence(jane, manchester), initial_fact,[]).
node(6, residence(adam, leeds), initial_fact,[]).
node(7, tier1(manchester), initial_fact, []).
node(8, tier1(leeds), initial_fact, []).

node(9, taste_and_smell(jane),initial_fact, []).
node(10, taste_and_smell(adam), initial_fact, []).
node(11, positive_pcr(beth), initial_fact, []).
node(12, meet_indoors(beth,adam), initial_fact, []).

rule(1, [not(taste_and_smell(X))], symptoms(X)).
rule(2, [negative_lft(X)], pcr(X)).
rule(3, [pinged(X), vaccinated(X), not(test(X))], self_isolate(X)).
rule(4, [positive_pcr(X), meet_indoors(X,Y)], pinged(Y)).
rule(5, [residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B), not(symptoms(X)), not(symptoms(A))],can_meet_indoors(X, A)).
rule(6, [tier1(X)], indoor_meetings_allowed(X)).
rule(7, [not(self_isolate(X)),not(self_isolate(Y)),can_meet_indoors(X, Y),vaccinated(X),vaccinated(Y)], eat_lunch(X,Y)).
rule(8, [negative_pcr(X)], pcr(X)).
rule(9, [negative_lft(X)], lft(X)).
rule(10, [pcr(X)], test(X)).
rule(11, [lft(X)], test(X)).
rule(12,[two_dose_v(X)], vaccinated(X)).


%% A set of user facts and rules 
user_fact(1, two_dose_v(jane), initial_fact, []).
user_fact(2, two_dose_v(adam), initial_fact, []).
user_fact(3, negative_lft(jane),initial_fact, []).
%% node(4, negative_pcr(adam), initial_fact, []).

user_fact(4, residence(jane, manchester), initial_fact,[]).
user_fact(5, residence(adam, leeds), initial_fact,[]).
user_fact(6, tier1(manchester), initial_fact, []).
user_fact(7, tier1(leeds), initial_fact, []).

user_fact(8, taste_and_smell(jane),initial_fact, []).
user_fact(9, taste_and_smell(adam), initial_fact, []).
user_fact(10, positive_pcr(beth), initial_fact, []).
user_fact(11, meet_indoors(beth,adam), initial_fact, []).

conclusion(eat_lunch(jane,adam)).



user_rule(1, [not(taste_and_smell(X))], symptoms(X)).
user_rule(2, [negative_lft(X)], pcr(X)).
user_rule(3, [pinged(X), vaccinated(X), not(test(X))], self_isolate(X)).
user_rule(4, [positive_pcr(X), meet_indoor(X,Y)], pinged(Y)).
user_rule(5, [residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B), not(symptoms(X)), not(symptoms(A))],can_meet_indoors(X, A)).
user_rule(6, [tier1(X)], indoor_meetings_allowed(X)).
user_rule(7, [not(self_isolate(X)),not(self_isolate(Y)),vaccinated(X),vaccinated(Y),can_meet_indoors(X, Y)], eat_lunch(X,Y)).
user_rule(8, [negative_pcr(X)], pcr(X)).
user_rule(9, [negative_lft(X)], lft(X)).
user_rule(10, [pcr(X)], test(X)).
user_rule(11, [lft(X)], test(X)).
user_rule(12,[two_dose_v(X)], vaccinated(X)).

fact_description(two_dose_v(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," is vaccinated with two doses of any approved vaccine "),
    write(A), write(" is vaccinated with two doses of any approved vaccine ").
fact_description(vaccinated(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," vaccinated"),
     write(X), write(" vaccinated").
fact_description(taste_and_smell(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," have taste and smell"),
     write(X), write(" have taste and smell").
fact_description(negative_pcr(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," is negative in PCR test"),
     write(X), write(" is negative in PCR test").
 fact_description(negative_lft(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," is negative in lft test"),
     write(X), write(" is negative in lft test").
fact_description(residence(X,Y)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," lives in "), write(Out,Y),
     write(X), write(" lives in "), write(Y).
fact_description(tier1(X)):-
    nb_getval(fileOutput,Out),
     write(Out,X), write(Out," is in tier1"),
     write(X), write(" is in tier1").
fact_description(positive_pcr(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," is positive in PCR test"),
     write(X), write(" is positive in PCR test").
fact_description(self_isolate(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," need to self isolate"),
     write(X), write(" need to self isolate").
fact_description(indoor_meetings_allowed(Y)):-
    nb_getval(fileOutput,Out),
    write(Out,Y), write(Out," allows indoor meetings"),
     write(Y), write(" allows indoor meetings").
fact_description(can_meet_indoors(X, A)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," and "), write(Out,A),write(Out," can meet indoors"),
    write(X), write(" and "), write(A),write(" can meet indoors").
fact_description(test(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has already get a PCR or lft test"),
     write(X), write(" has already get a PCR or lft test").
fact_description(pinged(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," get close contact with someone with Covid"),
     write(X), write(" get close contact with someone with Covid").
fact_description(symptoms(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has symptoms"),
     write(X), write(" has symptoms").
fact_description(pcr(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has a PCR test"),
     write(X), write(" has a PCR test").
fact_description(lft(X)):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," has a lft test"),
     write(X), write(" has a lft test").
fact_description(meet_indoors(X,Y)):-
     nb_getval(fileOutput,Out),
      write(Out,X),  write(Out," and "),  write(Out,Y), write(Out," has met indoor"),
     write(X),  write(" and "),  write(Y), write(" has met indoor").
fact_description(eat_lunch(X,Y)):-
    nb_getval(fileOutput,Out),
    write(Out,X),  write(Out," and "),  write(Out,Y), write(Out," can eat lunch together"),
     write(X),  write(" and "),  write(Y), write(" can eat lunch together").
fact_description(pinged(A)):-
    nb_getval(fileOutput,Out),
    write(Out,A), write(Out," has been in close contact with someone who has Covid-19 "),
     write(A), write(" has been in close contact with someone who has Covid-19 ").

fact_description(not(test(X))):-
    nb_getval(fileOutput,Out),
     write(Out,X), write(Out," doesn't take a test"),
     write(X), write(" doesn't take a test").

fact_description(not(taste_and_smell(X))):-
    nb_getval(fileOutput,Out),
     write(Out,X), write(Out," doesn't have taste and smell"),
     write(X), write(" doesn't have taste and smell").

fact_description(not(symptoms(X))):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," doesn't have any symptoms"),
     write(X), write(" doesn't have any symptoms").

fact_description(not(self_isolate(X))):-
    nb_getval(fileOutput,Out),
    write(Out,X), write(Out," doesn't need to self isolate"),
     write(X), write(" doesn't need to self isolate").

rule_description(1):-
    nb_getval(fileOutput,Out),
    write(Out,"1. If someone doesn't have a sense of taste and smell, then he/she has symptoms."),
    write("1. If someone doesn't have a sense of taste and smell, then he/she has symptoms.").

rule_description(2):-
    nb_getval(fileOutput,Out),
    write(Out,"2. If someone has a negative LFT test then he/she has taken and LFT test."),
    write("2. If someone has a negative LFT test then he/she has taken an LFT test.").

rule_description(3):-
    nb_getval(fileOutput,Out),
     write(Out,"3. If someone has been in close contact with someone who has Covid-19 and he/she is vaccinated, and he/she doesn't take a test then he/she needs to self-isolate."),
    write("3. If someone has been in close contact with someone who has Covid-19 and he/she is vaccinated, and he/she doesn't take a test then he/she needs to self-isolate.").

rule_description(4):-
    nb_getval(fileOutput,Out),
    write(Out,"4. If someone meets a person who has a positive PCR test, then he/she has been in close contact with someone who has Covid-19."),
    write("4. If someone meets a person who has a positive PCR test, then he/she has been in close contact with someone who has Covid-19.").

rule_description(5):-
    nb_getval(fileOutput,Out),
    write(Out,"5. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings, and both of them don't have symptoms, then these two people can meet indoors."),
    write("5. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings, and both of them don't have symptoms, then these two people can meet indoors.").

rule_description(6):-
    nb_getval(fileOutput,Out),
    write(Out,"6. If a city is in tier1 then this city allows indoor meetings."),
    write("6. If a city is in tier1 then this city allows indoor meetings.").

rule_description(7):-
    nb_getval(fileOutput,Out),
    write(Out,"7. If A and B don't need to self-isolate and they can meet indoors and both of them are vaccinated, then A and B can eat lunch together."),
    write("7. If A and B don't need to self-isolate and they can meet indoors and both of them are vaccinated, then A and B can eat lunch together.").

rule_description(8):-
    nb_getval(fileOutput,Out),
    write(Out,"8. If someone is negative in a PCR test then he/she has taken a PCR test."),
    write("8. If someone is negative in a PCR test then he/she has taken a PCR test.").

rule_description(9):-
    nb_getval(fileOutput,Out),
    write(Out,"9. If someone is negative in a LFT test then he/she has taken an LFT test."),
    write("9. If someone is negative in a LFT test then he/she has taken an LFT test.").

rule_description(10):-
    nb_getval(fileOutput,Out),
    write(Out,"10. If someone has taken a PCR test then he/she has taken a test."),
    write("10. If someone has taken a PCR test then he/she has taken a test.").

rule_description(11):-
    nb_getval(fileOutput,Out),
    write(Out,"11. If someone took an LFT test then he/she has taken a test."),
    write("11. If someone took an LFT test then he/she has taken a test.").




%% Pretty print the system rules 

r_description(1):-
    nb_getval(fileOutput,Out),
    write(Out,"1. If someone doesn't have a sense of taste and smell, then he/she has symptoms."),
    write("1. If someone doesn't have a sense of taste and smell, then he/she has symptoms."),nl.

r_description(2):-
    nb_getval(fileOutput,Out),
    write(Out,"2. If someone has a negative LFT test then he/she has taken an LFT test."),
    write("2. If someone has a negative LFT test then he/she has taken an LFT test."),nl.

r_description(3):-
    nb_getval(fileOutput,Out),
     write(Out,"3. If someone has been in close contact with someone who has Covid-19 and he/she is vaccinated,and he/she doesn't take a test then he/she needs to self isolate."),
    write("3. If someone has been in close contact with someone who has Covid-19 and he/she is vaccinated,and he/she doesn't take a test then he/she needs to self isolate."),nl.

r_description(4):-
    nb_getval(fileOutput,Out),
    write(Out,"4. If someone meets a person who has a positive PCR test, then he/she has been in close contact with someone who has Covid-19."),
    write("4. If someone meets a person who has a positive PCR test, then he/she has been in close contact with someone who has Covid-19."),nl.

r_description(5):-
    nb_getval(fileOutput,Out),
    write(Out,"5. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings, and both of them don't have symptoms, then these two people can meet indoors."),
    write("5. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings, and both of them don't have symptoms, then these two people can meet indoors."),nl.

r_description(6):-
    nb_getval(fileOutput,Out),
    write(Out,"6. If a city is in tier1 then this city allows indoor meetings."),
    write("6. If a city is in tier1 then this city allows indoor meetings."),nl.

r_description(7):-
    nb_getval(fileOutput,Out),
    write(Out,"7. If A and B don't need to self-isolate and they can meet indoors and both of them are vaccinated, then A and B can eat lunch together."),
    write("7. If A and B don't need to self-isolate and they can meet indoors and both of them are vaccinated, then A and B can eat lunch together."),nl.

r_description(8):-
    nb_getval(fileOutput,Out),
    write(Out,"8. If someone is negative in a PCR test then he/she has taken a PCR test."),
    write("8. If someone is negative in a PCR test then he/she has taken a PCR test."),nl.

r_description(9):-
    nb_getval(fileOutput,Out),
    write(Out,"9. If someone is negative in a LFT test then he/she has taken an LFT test."),
    write("9. If someone is negative in a LFT test then he/she has taken an LFT test."),nl.

r_description(10):-
    nb_getval(fileOutput,Out),
    write(Out,"10. If someone has taken a PCR test then he/she has taken a test."),
    write("10. If someone has taken a PCR test then he/she has taken a test."),nl.


r_description(11):-
    nb_getval(fileOutput,Out),
     write(Out,"11. If someone took an LFT test then he/she has taken a test."),
    write("11. If someone took an LFT test then he/she has taken a test."),nl.





system_rule(Rule):-
    r_description(Rule).