:-dynamic node/4, rule/3.
%% The main difference between user and the computer is in user_fact mary is vaccinated and mary is negative, 
%% and the computer fact does not have that 


node(1, taste_and_smell(mary), initial_fact, []).
node(2, taste_and_smell(karl), initial_fact, []).
node(3, pinged(karl), initial_fact, []).
node(4, vaccinated(karl), initial_fact, []).
node(5, pinged(mary), initial_fact, []).
node(6, positive_lft(mary),initial_fact, []).
node(7, cough(mary), initial_fact, []).

# node(6, vaccinated(mary), initial_fact, []).
# node(7, negative_pcr(mary), initial_fact, []).

rule(1, [cough(X)], symptoms(X)).
rule(2, [fever(X)], symptoms(X)).
rule(3, [not(taste_and_smell(X))], symptoms(X)).
rule(4, [positive_pcr(X)], self_isolate(X)).
rule(5, [positive_lft(X), not(pcr(X))], get_pcr(X)).
rule(6, [positive_lft(X), not(pcr(X))], self_isolate(X)).
rule(7, [symptoms(X)], get_pcr(X)).
rule(8, [pinged(X), not(vaccinated(X)), not(test(X))], self_isolate(X)).
rule(9, [pinged(X), not(vaccinated(X))], get_test(X)).
rule(10, [negative_pcr(X)], pcr(X)).
rule(11, [positive_pcr(X)], pcr(X)).
rule(12, [negative_lft(X)], lft(X)).
rule(13, [positive_lft(X)], lft(X)).
rule(14, [pcr(X)], test(X)).
rule(15, [lft(X)], test(X)).


%% A set of user facts and rules 
user_fact(1, taste_and_smell(mary), initial_fact, []).
user_fact(2, taste_and_smell(karl), initial_fact, []).
user_fact(3, pinged(karl), initial_fact, []).
user_fact(4, vaccinated(karl), initial_fact, []).
user_fact(5, pinged(mary), initial_fact, []).
# user_fact(6, vaccinated(mary), initial_fact, []).
# user_fact(7, negative_pcr(mary), initial_fact, []).

initial_question(1,self_isolate(mary), "Does Mary need to self isolate?").
initial_question(2,self_isolate(karl), "Does karl need to self isolate?").
initial_question(3,get_pcr(mary), "Does Mary need to get a test?").
initial_question(4,get_pcr(karl), "Does Karl need to get a test?").


user_rule(1, [cough(X)], symptoms(X)).
user_rule(2, [fever(X)], symptoms(X)).
user_rule(3, [not(taste_and_smell(X))], symptoms(X)).
user_rule(4, [positive_pcr(X)], self_isolate(X)).
user_rule(5, [positive_lft(X), not(pcr(X))], get_pcr(X)).
user_rule(6, [positive_lft(X), not(pcr(X))], self_isolate(X)).
user_rule(7, [symptoms(X)], get_pcr(X)).
user_rule(8, [pinged(X), not(vaccinated(X)), not(test(X))], self_isolate(X)).
user_rule(9, [pinged(X), not(vaccinated(X))], get_test(X)).
user_rule(10, [negative_pcr(X)], pcr(X)).
user_rule(11, [positive_pcr(X)], pcr(X)).
user_rule(12, [negative_lft(X)], lft(X)).
user_rule(13, [positive_lft(X)], lft(X)).
user_rule(14, [pcr(X)], test(X)).
user_rule(15, [lft(X)], test(X)).

fact_description(cough(X)):-
     write(X), write(" has cough").

fact_description(fever(X)):-
     write(X), write(" has fever").

fact_description(taste_and_smell(X)):-
     write(X), write(" have taste and smell").

fact_description(positive_pcr(X)):-
     write(X), write(" is positive in pcr test").

fact_description(negative_pcr(X)):-
     write(X), write(" is negative in pcr test").

fact_description(self_isolate(X)):-
     write(X), write(" need to self isolate").

 fact_description(positive_lft(X)):-
     write(X), write(" is postive in lft test").

 fact_description(negative_lft(X)):-
     write(X), write(" is negative in lft test").

fact_description(get_pcr(X)):-
     write(X), write(" need to get a pcr test").
fact_description(get_test(X)):-
     write(X), write(" need to get a pcr or lft test").

fact_description(test(X)):-
     write(X), write(" has already get a pcr or lft test").


fact_description(pinged(X)):-
     write(X), write(" get close contact with someone with Covid").

fact_description(vaccinated(X)):-
     write(X), write(" vaccinated").

fact_description(symptoms(X)):-
     write(X), write(" has symptoms").

fact_description(pcr(X)):-
     write(X), write(" has a pcr test").

fact_description(lft(X)):-
     write(X), write(" has a lft test").

fact_description(not(vaccinated(X))):-
     write(X), write(" doesn't vaccinate").

fact_description(not(pcr(X))):-
     write(X), write(" doesn't take a pcr test").

fact_description(not(test(X))):-
     write(X), write(" doesn't take a pcr or lft test").

fact_description(not(taste_and_smell(X))):-
     write(X), write(" doesn't have taste and smell").

fact_description(not(symptoms(X))):-
     write(X), write(" doesn't have any symptoms").



rule_description(1):-
    write("1. If someone has cough, he/she has symptoms."),nl.

rule_description(2):-
    write("2. If someone has fever, he/she has symptoms."),nl.

rule_description(3):-
    write("3. If someone doesn't have taste or smell, he/she has symptoms."),nl.

rule_description(4):-
    write("4. If someone's pcr result is positive, he/she need to self isolate "),nl.

rule_description(5):-
    write("5. If someone's lft result is positive and he doesn't take a pcr test, then he need to get a pcr test."),nl.

rule_description(6):-
    write("6. If someone's lft result is positive and he doesn't take a pcr test, then he need to self isolate"),nl.

rule_description(7):-
    write("7. If someone has symptoms, then he need to get a pcr test"),nl.

rule_description(8):-
    write("8. If someone get close contact with a person with Covid and he/she is not vaccinated, and he/she doesn't have a pcr or lft test yet, then he need to self isolate"),nl.

rule_description(9):-
    write("9. If someone get close contact with a person with Covid and he/she is not vaccinated, then he/she need to take a pcr or lft test."),nl.

rule_description(10):-
    write("10. If someone is negative in pcr test then he/she has taken a pcr test."),nl.

rule_description(11):-
    write("11. If someone is positive in pcr test then he/she has taken a pcr test."),nl.


rule_description(12):-
    write("12. If someone is negative in lft test then he/she has taken a lft test."),nl.

rule_description(13):-
    write("13. If someone is positive in lft test then he/she has taken a lft test."),nl.


rule_description(14):-
    write("14. If someone taken a pcr test then he/she has taken a test."),nl.


rule_description(15):-
    write("15. If someone taken a lft test then he/she has taken a test."),nl.




%% Pretty print the system rules 
r_description(1):-
    write("1. If someone has cough, he/she has symptoms."),nl.

r_description(2):-
    write("2. If someone has fever, he/she has symptoms."),nl.

r_description(3):-
    write("3. If someone doesn't have taste or smell, he/she has symptoms."),nl.

r_description(4):-
    write("4. If someone's pcr result is positive, he/she need to self isolate "),nl.

r_description(5):-
    write("5. If someone's lft result is positive and he doesn't take a pcr test, then he need to get a pcr test."),nl.

r_description(6):-
    write("6. If someone's lft result is positive and he doesn't take a pcr test, then he need to self isolate"),nl.

r_description(7):-
    write("7. If someone has symptoms, then he need to get a pcr test"),nl.

r_description(8):-
    write("8. If someone get close contact with a person with Covid and he/she is not vaccinated, and he/she doesn't have a pcr or lft test yet, then he need to self isolate"),nl.

r_description(9):-
    write("9. If someone get close contact with a person with Covid and he/she is not vaccinated, then he/she need to take a pcr or lft test."),nl.

r_description(10):-
    write("10. If someone is negative in pcr test then he/she has taken a pcr test."),nl.

r_description(11):-
    write("11. If someone is positive in pcr test then he/she has taken a pcr test."),nl.


r_description(12):-
    write("12. If someone is negative in lft test then he/she has taken a lft test."),nl.

r_description(13):-
    write("13. If someone is positive in lft test then he/she has taken a lft test."),nl.


r_description(14):-
    write("14. If someone taken a pcr test then he/she has taken a test."),nl.


r_description(15):-
    write("15. If someone taken a lft test then he/she has taken a test."),nl.



system_rule(Rule):-
    r_description(Rule).