/*
Ejercicio 1
I. juan IV. abuelo(juan, X). V. hermano(pablo,X).
*/
padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).
hijo(X,Y) :- padre(Y,X).
hermano(X,Y) :- padre(Z,X), padre(Z,Y).
descendiente(X,Y) :- padre(Y,X).
descendiente(X,Y) :- padre(Z,X), descendiente(Z,Y).
ancestro(X,X).
ancestro(X,Y) :- padre(X,Z), ancestro(Z,Y).

/*
Ejercicio 3
II. Se cuenga el programa en prolog cuando la consulta realizada unifica 
constantemente en una regla que no le permite llegar a un hecho, esto sucede
debido a que la ejecucion es de arriba para abajo en prolog.
*/

natural(0).
natural(suc(X)) :- natural(X).
menorOIgual(X,X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).

/*
Ejercicio 4
*/

juntar([],XS,XS).
juntar([X | XS], YS, [X | ZS]) :- juntar(XS,YS,ZS).

/* Ejercicio 5 */

last(XS, Y) :- append(_,[Y],XS).
reverse([],[]).
reverse([X | XS],YS) :- reverse(XS,ZS), append(ZS,[X],YS).
prefijo(P,L) :- append(P,_,L).
sufijo(S,L) :- append(_,S,L).
sublista([],_).
sublista(S,L) :- append(_,XS,L), append(S,_,XS), S \= [].
pertenece(X,L) :- append(_,[X | _],L).

/* Ejercicio 6 */

aplanar([],[]).
aplanar([XS | YS], LS) :- append(XS,YS,ZS), aplanar(ZS, LS).
aplanar([X | XS], [X | YS]) :- aplanar(XS,YS), X \= [_ | _], X \= []. 

/* Ejercicio 7 */
intersección([],_,[]).
intersección([X|XS],YS,[X|ZS]) :- member(X,YS), intersección(XS,YS,ZS).
intersección([X|XS],YS,ZS) :- not(member(X,YS)), intersección(XS,YS,ZS).

%partir(N, L, L1, L2) es reversible en L1 y L2.
partir(0,[X|XS],[],[X|XS]).
partir(N,[X|XS],[X|YS],ZS) :- M is N-1, partir(M,XS,YS,ZS).

borrar([],_,[]).
borrar([E|XS],E,YS) :- borrar(XS,E,YS).
borrar([X|XS],E,[X|YS]) :- X \= E, borrar(XS,E,YS).

sacarDuplicados([],[]).
sacarDuplicados([X|XS],[X|YS]) :-  not(member(X,XS)), sacarDuplicados(XS,YS).
sacarDuplicados([X|XS],YS) :- not(not(member(X, XS))), sacarDuplicados(XS,YS).

%permutación(+L1, ?L2)
permutación([],[]).
permutación(XS,[Y|YS]) :- not(not(member(Y,XS))), append(A,[Y|B],XS), append(A,B,L), permutación(L,YS).

%permutación(+L1, +L2)
permutación2([],[]).
permutación2([X|XS],YS) :- member(X,YS), append(A,[X|B],YS), append(A,B,L), permutación(XS,L).

reparto([],0,[]).
reparto(L,N,[X|LL]):- N > 0, append(X,B,L), M is N-1, reparto(B,M,LL).

repartoSinVacias([],0,[]).
repartoSinVacias(L,N,[X|LL]):- N > 0, append(X,B,L), X \= [], M is N-1, repartoSinVacias(B,M,LL).

/* Ejercicio 8 */


/* Ejercicio 9 */
% I. Debería instanciarse como desde(+X, +Y)

desde(X,X).
desde(X,Y) :- X < Y, N is X+1, desde(N,Y).

/* Ejercicio 10 */
intercalar([],L2,L2).
intercalar(L1,[],L1).
intercalar([X|L1],[Y|L2],[X|[Y|L3]]) :- intercalar(L1,L2,L3).
%Es reversible
%intercalar(+L1,+L2,-L3) y %intercalar(-L1,-L2,+L3)

/* Ejercicio 11 */
vacio(nil).
raiz(bin(_,X,_), X). 
altura(nil,0).
altura(bin(I,_,R),N) :- altura(I,M), not(altura(R,M)), N is M+1.

/* Ejercicio 12 */
inorder(nil,[]).
inorder(bin(I,R,D),L) :- inorder(I,L2), inorder(D,L3), append(L2,[R|L3],L).
arbolConInorder([],nil).
arbolConInorder(XS,bin(I,R,D)) :- append(A,[R|B],XS), arbolConInorder(A,I), arbolConInorder(B,D).

creciente([]).
creciente([_]).
creciente([X|[Y|YS]]) :- X < Y, creciente([Y|YS]).
aBB(T) :- inorder(T,L), creciente(L).
%PENSAR UNA FORMA SIN AUXILIAR

/* Ejercicio 13 */
coprimos(X,Y) :- between(2,inf,N), between(1,N,X), Y is N-X, gcd(X,Y) =:= 1.

/* Ejercicio 22 
%caminoSimple(+G,+D,+H,?L)
caminoSimple(G,D,D,[D]).
caminoSimple(G,D,H,[D|[V|L]]) :- not(member(D,[V|L])), esNodo(G,D), esNodo(G,H), esArista(G,D,V), caminoSimple(G,V,H,[V|L]).

caminoHamiltoniano(G,[]) :- not(esNodo(G,X)).
caminoHamiltoniano(G,[D|L]) :- esNodo(G,A), caminoSimple(G), not(())
*/


