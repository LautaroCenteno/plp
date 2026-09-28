import Control.Arrow (ArrowZero(zeroArrow))
import Data.Foldable (Foldable(fold))
import GHC.Base (DoubleBox)
import Data.Bifoldable (bifoldl1)

--ejercicio2

curry :: ((a,b) -> c) -> (a -> b -> c)
curry f = \x y -> f(x,y)

uncurry :: (a -> b -> c) -> ((a, b) -> c)
uncurry f = \(x,y) -> f x y



--ejercicio 3

--ejercicio 4
paresDeNat :: [(Int, Int)]
paresDeNat = [(x, s - x) | s <- [0 ..], x <- [0 .. s]] -- paresDeNat4 es nuestra solución final

paresDeNat1 = [(x, y) | x <- [0 ..], y <- [0 ..]]

paresDeNat2 =
  [(x, y) | x <- [0 ..], y <- [0 ..], y <= x]

paresDeNat3 =
  [(x, y) | x <- [0 ..], y <- [0 .. x]]

paresDeNat4 =
  [(x, s - x) | s <- [0 ..], x <- [0 .. s]]

paresDeNat5 =
  [(x, y) | s <- [0 ..], x <- [0 .. s], y <- [0 .. s], x + y == s]


--ejercicio 5

--ejercicio 6
listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n = [x:xs | x <- [1..n], xs <- listasQueSuman (x-n)]

--ejercicio 7
listasPositivos :: [[Int]]
listasPositivos = concatMap listasQueSuman [0..]

--ejercicio 8
--I
menosCinco :: [String] -> [String]
menosCinco [] = []
menosCinco xs = filter ((<5) . length) xs

listaAprobados :: Integral a => [a] -> [Bool]
listaAprobados [] = []
listaAprobados xs = map (>= 6) xs

paresCuadrados :: Integral a => [a] -> [a]
paresCuadrados [] = []
paresCuadrados xs = map (^2) (filter ((== 0) . mod 2) xs)
--II
sumFold :: Num a => [a] -> a
sumFold = foldr (+) 0

elemFold :: Eq a => a -> [a] -> Bool
elemFold e = foldr (\x rec -> x == e || rec) (False)

masmasFold :: [a] -> [a] -> [a]
masmasFold xs ys = foldr (:) ys xs

filterFold :: (a -> Bool) -> [a] -> [a]
filterFold f = foldr (\x rec -> if f x then x : rec else rec) []

mapFold :: (a -> b) -> [a] -> [b]
mapFold f = foldr (\x rec -> f x : rec) []

--III
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f = foldr1 (\x y -> if f x y then x else y)

--IV
sumasParciales :: Num a => [a] -> [a]
sumasParciales [] = []
sumasParciales (x:xs) = reverse (foldl (\e y -> (y + head e) : e) [x] xs)

--V
sumaAlt:: Num a => [a] -> a
sumaAlt = foldr (-) 0

--VI
sumaAlt2:: Num a => [a] -> a
sumaAlt2 = foldl (flip (-)) 0

--VII
componerTodas :: [a -> a] -> (a -> a)
componerTodas = foldr (.) id

--Ejercicio 10
--a
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b 
recr _ z [] = z 
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e = recr (\x xs ys -> if x == e then xs else x : ys) [] 
--b
--RESOLVER
--c
insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e = recr (\x xs rec -> if e <= x then e : x : xs else x:rec) [e]

--Ejercicio 11
{- 
ElementosEnPosiciones pares usa recurcion global.


-}

--Ejercicio 14
data Nat = Zero | Succ Nat

foldNat:: (a -> a) -> a -> Int -> a
foldNat f z 0 = z
foldNat f z n = f (foldNat f z (n-1))

potencia:: Int -> Int -> Int
potencia a = foldNat (* a) 1

--ejercicio 16
data Polinomio a = X
  | Cte a
  | Suma (Polinomio a) (Polinomio a)
  | Prod (Polinomio a) (Polinomio a)

foldPoli :: (a -> b) -> (b -> b -> b) -> ( b -> b -> b) -> b -> Polinomio a -> b
foldPoli fcte fsuma fprod cb poli = case poli of
  X -> cb
  Cte a -> fcte a
  Suma p1 p2 -> fsuma (foldPoli fcte fsuma fprod cb p1) (foldPoli fcte fsuma fprod cb p2)
  Prod p1 p2 -> fprod (foldPoli fcte fsuma fprod cb p1) (foldPoli fcte fsuma fprod cb p2)

evaluar :: Num a => a -> Polinomio a -> a
evaluar = foldPoli id (+) (*)

--Ejercicio 17
data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: (b -> a -> b -> b) -> b -> AB a -> b
foldAB f z Nil = z
foldAB f z (Bin i r d) = f (foldAB f z i) r (foldAB f z d)

recAB :: (AB a -> a -> AB a -> b -> b -> b) -> b -> AB a -> b
recAB f z Nil = z
recAB f z (Bin i r d) = f i r d (recAB f z i) (recAB f z d)

esNil :: AB a -> Bool
esNil Nil = True
esNil _ = False

esNil2 :: AB a -> Bool
esNil2 a = case a of
  Nil -> True
  _ -> False

altura :: AB a -> Int
altura = foldAB (\rec1 n rec2 -> 1 + max rec1 rec2) 0

cantNodos :: AB a -> Int
cantNodos = foldAB (\rec1 n rec2 -> rec1 + 1 + rec2) 0
{- 
mejorSegunAB :: (a -> a -> Bool) -> AB a -> a
mejorSegunAB f (Bin i r d) = case 
  foldAB (\i r d rec1 rec2 -> )
    -}

--ejercicio 22
data Buffer a = Empty | Write Int a (Buffer a) | Read Int (Buffer a) deriving Show

foldBuffer :: b -> (Int -> a -> b -> b) -> (Int -> b -> b) -> Buffer a -> b
foldBuffer z fw fr b = case b of
  Empty -> z
  Write nw aw bw -> fw nw aw (foldBuffer z fw fr bw)
  Read nr br -> fr nr (foldBuffer z fw fr br)

recBuffer :: b -> (Int -> a -> Buffer a -> b -> b) -> (Int -> Buffer a -> b -> b) -> Buffer a -> b
recBuffer z fw fr b = case b of
  Empty -> z
  Write nw aw bw -> fw nw aw bw (recBuffer z fw fr bw)
  Read nr br -> fr nr br (recBuffer z fw fr br)

quitar :: Int -> [Int] -> [Int]
quitar n = foldr (\x rec -> if x == n then rec else x : rec) [] 

pertenece :: Int -> [Int] -> Bool
pertenece n = foldr (\x rec -> x == n || rec) False

posicionesOcupadas :: Buffer a -> [Int]
posicionesOcupadas = foldBuffer [] (\i x rc -> i : quitar i rc) (\i rc -> quitar i rc)

contenido::Int -> Buffer a -> Maybe a
contenido n = foldBuffer Nothing (\i x rc -> if i == n then Just x else rc) (\i rc -> if i == n then Nothing else rc)

puedeCompletarLecturas::Buffer a -> Bool
puedeCompletarLecturas = recBuffer True (\i x br rc -> rc) (\i br rc -> pertenece i (posicionesOcupadas br) && rc)

deshacer::Buffer a -> Int -> Buffer a
deshacer = recBuffer (\n -> Empty) (\i x br rc n -> if n > 0 then rc (n-1) else Write i x br) (\i br rc n -> if n > 0 then rc (n-1) else Read i br)