
--ejercicio2

curry :: ((a,b) -> c) -> (a -> b -> c)
curry f = \x y -> f(x,y)

uncurry :: (a -> b -> c) -> ((a -> b) -> c)
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

listaAprobados :: [Int] -> [Bool]
listaAprobados [] = []
listaAprobados xs = map (>= 6) xs

paresCuadrados :: Num a => [a] -> [a]
paresCuadrados [] = []
paresCuadrados xs = map (^2) (filter ((==0) . mod 2) xs)