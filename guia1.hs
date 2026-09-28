import Control.Arrow (ArrowZero(zeroArrow))
import Data.Foldable (Foldable(fold))
import GHC.Base (DoubleBox)

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