--import GHC.Generics (FixityI(InfixI))
--ejercicio 1

--I

--max2 :: (Float, Float) -> Float
--normaVectorial :: (Float, Float) -> Float
--subtract :: Float -> Float -> Float
--predecesor :: Float -> Float
--evaluarEnCero CONSULTAR
--dosVeces CONSULTAR
--flipAll :: [(a -> b -> c) -> b -> a] CONSULTAR
--flipRaro :: a -> b -> c CONSULTAR

--II

--No, max2 :: Float -> Float -> Float
--No, normaVectorial :: Float -> Float -> Float
--Si
--Si
--
--
--

--Ejercicio 2

--I

--curry :: ((a,b) -> c) -> (a -> b -> c)
--curry f x y = f (x, y)

--II

--uncurry :: (a -> b -> c) -> ((a,b) -> c)
--uncurry f (x, y) = f x y

--III

--curryN :: ((a1, ..., an) -> b) -> (a1 -> .. -> an -> b)

--ejercicio 3

--I

sum :: Num a => [a] -> a
sum = foldr (+) 0

--elem :: Eq a => a -> [a] -> Bool
--elem | 

masmas ::  [a] -> [a] -> [a] -- (++)
masmas xs ys = foldr (:) (ys) xs

filter :: (a -> Bool) -> [a] -> [a]
filter f xs = foldr (\ x acc -> if f x then x:acc else acc) [] xs    --NO SE ME OCURRIO A MI, bastante rebuscado. No encontré otra solución

map2 :: (a -> b) -> [a] -> [b]
map2 f xs = foldr (\x acc -> (f x):acc) [] xs  --use la logica del anterior para resolverlo


--II
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f xs = foldr1 (\a b -> if f a b then a else b) xs

--III
sumaLista:: Num a => [a] -> a
sumaLista [] = 0
sumaLista (x:xs) = x + sumaLista xs

--sumasParciales :: Num a => [a] -> [a]
--sumasParciales 



--IV

--V

--ejercicio 4

--I
--permutaciones:: [a] -> [[a]]
--permutaciones [] = []
--permutaciones (x:xs) = 
--

--ejercicio 5

--elementosEnPosicionesPares NO es estructural, es global
--entrelazar es recursion estructural.
--entrelazar:: [a] -> [a]
--entrelazar [] = id
--entrelazar (x:xs) ys = if null ys
--                          then 

