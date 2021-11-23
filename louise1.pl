%% A set of computer facts and rules 

node(1, residence(mary, manchester), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).

rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B)],can_meet_indoors(X, A)).
rule(2,[tier1(X)], indoor_meetings_allowed(X)).

initial_question(1,can_meet_indoors(mary, karl), "Can Mary and Karl meet indoors?").
%initial_question(1,can_meet_indoors(mary, sue), "Can Mary and sue meet indoors?").

%% A set of user facts and rules 
user_fact(1,residence(mary, manchester),initial_fact,[]).
user_fact(1,residence(karl, stockport),initial_fact,[]).
user_fact(1,tier2(stockport),initial_fact,[]).

user_rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B)],can_meet_indoors(X, A)).
user_rule(2,[tier1(X)], indoor_meetings_allowed(X)).

% user_rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), not(indoor_meetings_allowed(B))],not(can_meet_indoors(X, A))).
% user_rule(2,[tier2(X)], not(indoor_meetings_allowed(X))).




