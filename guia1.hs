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

--sum :: Num a => [a] -> a
--sum = foldr (+) 0

--elem

