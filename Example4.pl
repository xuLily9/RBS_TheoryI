:-dynamic node/4, rule/3.
%% The main difference between user and the computer is in user_fact mary is vaccinated and mary is negative, 
%% and the computer fact does not have that 

node(1, vaccinated(jane), initial_fact, []).
node(2, vaccinated(adam), initial_fact, []).
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
rule(7, [not(self_isolate(X)),not(self_isolate(Y)),can_meet_indoors(X, Y)], eat_lunch(X,Y)).
rule(8, [negative_pcr(X)], pcr(X)).
rule(9, [negative_lft(X)], lft(X)).
rule(10, [pcr(X)], test(X)).
rule(11, [lft(X)], test(X)).



%% A set of user facts and rules 
user_fact(1, vaccinated(jane), initial_fact, []).
user_fact(2, vaccinated(adam), initial_fact, []).
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

initial_question(1,eat_lunch(jane,adam), "Can jane and adam eat lunch together?").



user_rule(1, [not(taste_and_smell(X))], symptoms(X)).
user_rule(2, [negative_lft(X)], pcr(X)).
user_rule(3, [pinged(X), vaccinated(X), not(test(X))], self_isolate(X)).
user_rule(4, [positive_pcr(X), meet_indoor(X,Y)], pinged(Y)).
user_rule(5, [residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B), not(symptoms(X)), not(symptoms(A))],can_meet_indoors(X, A)).
user_rule(6, [tier1(X)], indoor_meetings_allowed(X)).
user_rule(7, [not(self_isolate(X)),not(self_isolate(Y)),can_meet_indoors(X, Y)], eat_lunch(X,Y)).
user_rule(8, [negative_pcr(X)], pcr(X)).
user_rule(9, [negative_lft(X)], lft(X)).
user_rule(10, [pcr(X)], test(X)).
user_rule(11, [lft(X)], test(X)).

fact_description(vaccinated(X)):-
     write(X), write(" vaccinated").
fact_description(taste_and_smell(X)):-
     write(X), write(" have taste and smell").
fact_description(negative_pcr(X)):-
     write(X), write(" is negative in pcr test").
 fact_description(negative_lft(X)):-
     write(X), write(" is negative in lft test").
fact_description(residence(X,Y)):-
     write(X), write(" lives in "), write(Y).
fact_description(tier1(X)):-
     write(X), write(" is in tier1").
fact_description(positive_pcr(X)):-
     write(X), write(" is positive in pcr test").
fact_description(self_isolate(X)):-
     write(X), write(" need to self isolate").
fact_description(indoor_meetings_allowed(Y)):-
     write(Y), write(" allows indoor meetings").
fact_description(can_meet_indoors(X, A)):-
    write(X), write(" and "), write(A),write(" can meet indoors").
fact_description(test(X)):-
     write(X), write(" has already get a pcr or lft test").
fact_description(pinged(X)):-
     write(X), write(" get close contact with someone with Covid").
fact_description(symptoms(X)):-
     write(X), write(" has symptoms").
fact_description(pcr(X)):-
     write(X), write(" has a pcr test").
fact_description(lft(X)):-
     write(X), write(" has a lft test").
fact_description(meet_indoors(X,Y)):-
     write(X),  write(" and "),  write(Y), write(" has met indoor").
fact_description(eat_lunch(X,Y)):-
     write(X),  write(" and "),  write(Y), write(" can eat lunch together").
fact_description(pinged(A)):-
     write(A), write(" has been in close contact with someone who has Covid-19 ").

fact_description(not(test(X))):-
     write(X), write(" doesn't take a test").

fact_description(not(taste_and_smell(X))):-
     write(X), write(" doesn't have taste and smell").

fact_description(not(symptoms(X))):-
     write(X), write(" doesn't have any symptoms").

fact_description(not(self_isolate(X))):-
     write(X), write(" doesn't need to self isolate").

rule_description(1):-
    write("1. If someone doesn't have taste and smell, he/she has symptoms."),nl.

rule_description(2):-
    write("2. If someone is negative in lft test then he/she has taken a lft test."),nl.

rule_description(3):-
    write("3. If someone has been in close contact with someone who has Covid-19and he has vaccinated,and he doesn't take a test then he need to self isolate."),nl.

rule_description(4):-
    write("4. If someone meet a person who has positive pcr test, then he has been in close contact with someone who has Covid-19"),nl.

rule_description(5):-
    write("5. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings and both of them don't have symptoms, then these two people can meet indoors."),nl.

rule_description(6):-
    write("6. If there is a city in tier1 then this city allow indoor meetings."),nl.

rule_description(6):-
    write("6. If someone's lft result is positive and he doesn't take a pcr test, then he need to self isolate"),nl.

rule_description(7):-
    write("7. If A and B doesn't need to self_isolate and they can meet indoors, then A and B can eat lunch together "),nl.

rule_description(8):-
    write("8. If someone is negative in a pcr test then he/she has taken a pcr test."),nl.

rule_description(9):-
    write("9. If someone is negative in a lft test then he/she has taken a lft test."),nl.

rule_description(10):-
    write("10. If someone has taken a pcr test then he/she has taken a test."),nl.

rule_description(11):-
    write("11. If someone took a lft test then he/she has taken a test."),nl.




%% Pretty print the system rules 

r_description(1):-
    write("1. If someone doesn't have taste and smell, he/she has symptoms."),nl.

r_description(2):-
    write("2. If someone is negative in lft test then he/she has taken a lft test."),nl.

r_description(3):-
    write("3. If someone has been in close contact with someone who has Covid-19and he has vaccinated,and he doesn't take a test then he need to self isolate."),nl.

r_description(4):-
    write("4. If someone meet a person who has positive pcr test, then he has been in close contact with someone who has Covid-19"),nl.

r_description(5):-
    write("5. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings, then these two people can meet indoors."),nl.

r_description(6):-
    write("6. If there is a city in tier1 then this city allow indoor meetings."),nl.

r_description(6):-
    write("6. If someone's lft result is positive and he doesn't take a pcr test, then he need to self isolate"),nl.

r_description(7):-
    write("7. If A and B doesn't need to self_isolate and they can meet indoors, then A and B can eat lunch together "),nl.

r_description(8):-
    write("8. If someone is negative in a pcr test then he/she has taken a pcr test."),nl.

r_description(9):-
    write("9. If someone is negative in a lft test then he/she has taken a lft test."),nl.

r_description(10):-
    write("10. If someone has taken a pcr test then he/she has taken a test."),nl.


r_description(11):-
    write("11. If someone took a lft test then he/she has taken a test."),nl.





system_rule(Rule):-
    r_description(Rule).