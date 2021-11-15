node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).


rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B)],can_meet_indoors(X, A)).
rule(2,[tier1(X)], indoor_meetings_allowed(X)).

initial_question(1,can_meet_indoors(mary, karl), "Can Mary and Karl meet indoors?").

%% initial_question(1,can_meet_indoors(X, A)):-
%%	write("Can"),write(X),write(" and "),write(A),write(" meet indoors?").


