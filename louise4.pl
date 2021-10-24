:-dynamic node/4, rule/3.

node(1, taste_and_smell(mary), initial_fact, []).
node(2, taste_and_smell(karl), initial_fact, []).
node(3, pinged(karl), initial_fact, []).
node(4, vaccinated(karl), initial_fact, []).
node(5, pinged(mary), initial_fact, []).

rule(1, [cough(X)], symptoms(X)).
rule(2, [fever(X)], symptoms(X)).
rule(3, [not(taste_and_smell(X))], symptoms(X)).
rule(4, [positive_pcr(X)], self_isolate(X)).
rule(6, [positive_lft(X), not(pcr(X))], get_pcr(X)).
rule(7, [positive_lft(X), not(pcr(X))], self_isolate(X)).
rule(9, [symptoms(X)], get_pcr(X)).
rule(10, [pinged(X), not(vaccinated(X)), not(test(X))], self_isolate(X)).
rule(10, [pinged(X), not(vaccinated(X))], get_test(X)).
rule(11, [negative_pcr(X)], pcr(X)).
rule(12, [positive_pcr(X)], pcr(X)).
rule(13, [negative_lft(X)], lft(X)).
rule(14, [positive_lft(X)], lft(X)).
rule(15, [pcr(X)], test(X)).
rule(16, [lft(X)], test(X)).
