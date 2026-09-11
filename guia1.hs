
--ejercicio2

curry :: ((a,b) -> c) -> (a -> b -> c)
curry f = \x y -> f(x,y)

uncurry :: (a -> b -> c) -> ((a, b) -> c)
uncurry f = \(x,y) -> f x y



--ejercicio 3

--ejercicio 4

--ejercicio 5

--ejercicio 6

--ejercicio 7

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
--sacarUna :: Eq a => a -> [a] -> [a]
--sacarUna e = recr (\x xs rec -> if x == e then xs else x : rec) []
--b
--RESOLVER
--c
--instertarOrdenado :: Ord a => a -> [a] -> [a]
--insertarOrdenado e = recr (\x xs rec -> if e <= x then e : x : xs else) []
