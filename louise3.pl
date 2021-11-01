:-dynamic node/4, rule/3.

node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).
node(4, taste_and_smell(mary), initial_fact, []).
node(5, taste_and_smell(karl), initial_fact, []).


rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B), not(symptoms(X)), not(symptoms(A))],can_meet_indoors(X, A)).
rule(2,[tier1(X)], indoor_meetings_allowed(X)).
rule(3, [cough(X)], symptoms(X)).
rule(4, [fever(X)], symptoms(X)).
rule(5, [not(taste_and_smell(X))], symptoms(X)).

