% user has a fact and computer does not have

user_fact(1,residence(sarah, manchester),initial_fact,[]).
user_fact(3,residence(harry, london),initial_fact,[]).
user_fact(2,vaccinated(), initial_fact, []).
user_fact(2,vaccinated(sarah), initial_fact, []).
user_fact(2,vaccinated(sara), initial_fact, []).


user_rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B), not(symptoms(X)), not(symptoms(A))],can_meet_indoors(X, A)).
user_rule(2,[tier1(X)], indoor_meetings_allowed(X)).
