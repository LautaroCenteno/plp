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
interseccion([],_,[]).
interseccion(XS,YS,[Z|ZS]) :- append(A,[Z|B],XS), member(Z,YS), not(member(Z,B)), inter(B,YS,ZS).
inter([],_,[]).
inter([X|XS],YS,ZS) :- not(member(X,YS)), inter(XS,YS,ZS).
inter([X|XS],YS,[X|ZS]) :- member(X,YS).

/* Ejercicio 7 
vacio(nil).
raiz(bin(_,X,_), X). 
altura(nil,0).
altura(bin(I,_,R),N) :- altura(I,M), not(altura(R,M)), N is M+1.
*/