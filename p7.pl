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
parteQueSuma(_,0,[]).
parteQueSuma(L,S,[P|PS]) :- append(_,[P|B],L), S2 is S-P, parteQueSuma(B,S2,PS).

/* Ejercicio 9 */
% I. Debería instanciarse como desde(+X, +Y)

desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).

desdeReversible(X, Y) :- var(Y), desde(X, Y).
desdeReversible(X, Y) :- nonvar(Y), X =< Y.

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
altura(bin(I,_,D),N) :- altura(I,J), altura(D,K), N is max(J,K)+1.
cantidadDeNodos(nil,0).
cantidadDeNodos(bin(I,_,D),N) :- cantidadDeNodos(I,J), cantidadDeNodos(D,K), N is J + K + 1.

/* Ejercicio 12 */
inorder(nil,[]).
inorder(bin(I,R,D),L) :- inorder(I,L2), inorder(D,L3), append(L2,[R|L3],L).
arbolConInorder([],nil).
arbolConInorder(XS,bin(I,R,D)) :- append(A,[R|B],XS), arbolConInorder(A,I), arbolConInorder(B,D).
aBB(T) :- inorder(T,L), not((append(_,[X|B],L), member(Y,B), not(Y > X))).
aBBInsertar(X,T1,T2) :- inorder(T1,L), append(A,B,L), not((member(E,A), E > X, member(E2,B), E2 < X)), append(A,[X|B],L2), arbolConInorder(L2,T2), aBB(T2).



/* Ejercicio 13 */

coprimos(X,Y) :- between(2,inf,N), between(1,N,X), Y is N-X, gcd(X,Y) =:= 1.

/* Ejercicio 14 */
/*
SIN GENERATE AND TEST
*/
genFila(0,S,[]) :- S = 0.
genFila(N,S,[X|XS]) :- N > 0, between(0,S,X), M is N-1, S2 is S-X, genFila(M,S2,XS).
genMatriz(0,_,_,[]).
genMatriz(NM,NF,S,[X|XS]) :- NM > 0, genFila(NF,S,X), M is NM-1, genMatriz(M,NF,S,XS).
cuadradoSemiMagico(N,XS) :- desdeReversible(0,S), genMatriz(N,N,S,XS).

/* Ejercicio 15 */
%esTriangulo(tri(A,B,C)) :- A > 0, B > 0, C > 0, A < B+C, B < A+C, C < A+B, A > abs(B-C), B > abs(A-C), C > abs(A-B).
%perimetro(tri(A,B,C),P) :- nonvar(tri(A,B,C)), nonvar(P).

/* Ejercicio 17 */
% I. Devuelve aquellos Y que P(Y) da verdadero pero Q(Y) no.
% II. Devuelve solo los valores que valen Y cuando Q(Y) falla para todos los valores.
% III. P(Y), not((P(Z), Z \= Y))

/* Ejercicio 18 */
corteMásParejo(L,L1,L2) :- append(L1,L2,L), sum_list(L1,S1), sum_list(L2,S2), D1 is abs(S1-S2), not((append(L3,L4,L), L3 \= L1, sum_list(L3,S3), sum_list(L4,S4), D2 is abs(S3-S4), D2 < D1)).

/* Ejercicio 19 */
% P(Y), not((P(Z), Z<Y))

/* Ejercicio 20 */
primo(N) :- J is N-1, not((between(2,J,D), N mod D =:= 0)).
primosHasta(K,N) :- between(2,K,N), J is N-1, not((between(2,J,D), N mod D =:= 0)).
numerosPoderosos(K) :- desdeReversible(2,K), not((primosHasta(K,P), K mod P =:= 0, not(K mod (P*P) =:= 0))).
próximoNumPoderoso(X,Y) :- numerosPoderosos(Y), Y > X, N is X+1, not((between(N,Y,K), numerosPoderosos(K))).

/* Ejercicio 21 
conjuntoDeNaturales(X) :- not((pertenece(E,X), not(natural(E)))).

conjuntoDeNaturales(+X) debido a se utiliza la funcion pertenece (necesita que X esté instanciado para funcionar).
La definicion alternativa falla porque not no sirve para instanciar variables libres, en este caso E, 
por lo que conjuntoDeNaturalesMalo(X) va a devolver true 
cuando un elemento E cualquiera simplemente petrenezca a X.
Ademas not(natural(E), es siempre true.
*/

/* Ejercicio 22 
*/

%caminoSimple(+G,+D,+H,?L)
caminoSimple(G,D,D,[D]) :- esNodo(G,D).
caminoSimple(G,D,H,[D|[V|L]]) :- not(member(D,[V|L])), esNodo(G,D), esNodo(G,H), esArista(G,D,V), caminoSimple(G,V,H,[V|L]).

%caminoHamiltoniano(+G,?L)
caminoHamiltoniano(G,[]) :- not(esNodo(G,_)).
caminoHamiltoniano(G,L) :- esNodo(G,A), esNodo(G,B), caminoSimple(G,A,B,L), not((esNodo(G,C), not(member(C,L)))).

esConexo(G) :- not((esNodo(G,A), esNodo(G,B), not(caminoSimple(G,A,B,_)))).

%esEstrella(G) :- esConexo(G), not((esArista(G,X,Y) )).

/* Ejercicio 23
*/

arbolDeTamaño(0,nil).
arbolDeTamaño(N,bin(I,_,D)) :- N > 0, M is N-1, between(0,M,K), N2 is M-K, arbolDeTamaño(K,I), arbolDeTamaño(N2,D).
arbol(A) :- desdeReversible(0,N), arbolDeTamaño(N,A).

%SIN REVISAR
nodosEn(nil,[_|_]).
nodosEn(bin(I,R,D),L) :- member(R,L), nodosEn(I,L), nodosEn(D,L).

%SIN REVISAR
sinRepEn(nil,[_|_]).
sinRepEn(bin(I,R,D),L) :- member(R,L), append(A,[R|C],L), append(A,C,L2), append(U,V,L2), sinRepEn(I,U), sinRepEn(D,V).


/* Parcial */
nota(do).
nota(re).
nota(mi).
nota(fa).
nota(sol).
nota(la).

listaAMelodía([X],X) :- nota(X).
listaAMelodía(L,sec(M1,M2)) :- append(A,B,L), A \= [], B \= [], listaAMelodía(A,M1), listaAMelodía(B,M2).

subMelodía(M,M) :- not(nota(M)).
subMelodía(sec(M1,_),S) :- subMelodía(M1,S).
subMelodía(sec(_,M2),S) :- subMelodía(M2,S).
%Es reversible en S

sinSubmelodíasEnComun(M1,M2) :- not((subMelodía(M1,S1), subMelodía(M2,S2), S1 = S2)).

melodíaDeTamaño(1,N) :- nota(N).
melodíaDeTamaño(N,sec(M1,M2)) :- N > 1, M is N-1, between(1,M,K), N2 is N-K, melodíaDeTamaño(K,M1), melodíaDeTamaño(N2,M2).
melodía(M) :- desdeReversible(1,N), melodíaDeTamaño(N,M).