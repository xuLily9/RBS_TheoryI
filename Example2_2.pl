%% A set of computer facts and rules 

node(1, residence(sue, london), initial_fact,[]).
node(2, residence(karl, manchester), initial_fact,[]).
node(3, tier1(manchester), initial_fact, []).
node(4, tier2(london), initial_fact, []).

rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B)],can_meet_indoors(X, A)).
rule(2,[tier1(X)], indoor_meetings_allowed(X)).
rule(3,[tier2(X)], indoor_meetings_allowed(X)).

initial_question(1,can_meet_indoors(sue, karl), "Can Sue and Karl meet indoors?").


%% A set of user facts and rules 
user_fact(1,residence(mary, manchester),initial_fact,[]).
user_fact(2,residence(karl, stockport),initial_fact,[]).
user_fact(3,tier1(manchester),initial_fact,[]).
user_fact(4,tier2(london), initial_fact, []).


user_rule(1,[residence(X, Y), residence(A, B), indoor_meetings_allowed(Y), indoor_meetings_allowed(B)],can_meet_indoors(X, A)).
user_rule(2,[tier1(X)], indoor_meetings_allowed(X)).


fact_description(residence(X,Y)):-
     write(X), write(" lives in "), write(Y).

fact_description(tier1(X)):-
     write(X), write(" is in tier1").

fact_description(tier2(X)):-
     write(X), write(" is in tier2").

fact_description(indoor_meetings_allowed(Y)):-
     write(Y), write(" allows indoor meetings").

fact_description(can_meet_indoors(X, A)):-
    write(X), write(" and "), write(A),write(" can meet indoors").





rule_description(1):-
    write("1. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings, then these two people can meet indoors."),nl.

rule_description(2):-
    write("2. If there is a city in tier1 then this city allows indoor meetings."),nl.



%% Pretty print the system rules 
r_description(1):-
    write("1. If someone lives in a city that allows indoor meetings and another person also lives in a city that allows indoor meetings, then these two people can meet indoors").

r_description(2):-
    write("2. If there is a city in tier1 then this city allows indoor meetings").

system_rule(Rule):-
    r_description(Rule).