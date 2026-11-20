letra(a).
letra(b).

desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).

desdeReversible(X, Y) :- var(Y), desde(X, Y).
desdeReversible(X, Y) :- nonvar(Y), X =< Y.

esRacha(R) :- not((member(L,R), not(letra(L)))), not((member(L1,R), member(L2,R), L1 \= L2)).

rachaCompleta(P,R) :- append(A,B,P), append(C,[L|D],A), esRacha([L|D]), length([L|D],T), R = [L|D], reverse(B,RB), not((last(RB, LRB), LRB = L)), not((last(C,LC), LC = L)).

palabraDeTamaño(1,[L]) :- letra(L).
palabraDeTamaño(N,[L|P]) :- N > 1, letra(L), M is N-1, palabraDeTamaño(M,P).

palabra(M,P) :- desdeReversible(1,N), palabraDeTamaño(N,P), not((append(A,_,P), append(_,D,A), esRacha(D), length(D,T), T > M)).