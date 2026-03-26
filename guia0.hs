import Data.Bits (Bits(xor))
import Data.Functor.Classes (Ord2(liftCompare2))
--ejercicio2
--a
valorAbsoluto :: Float -> Float
valorAbsoluto x | x >= 0 = x
                | otherwise = -x

--b
bisiesto :: Int -> Bool
bisiesto a | mod a 400 == 0 || (mod a 4 == 0 && mod a 100 /= 0) = True
           | otherwise = False

--c
factorial :: Int -> Int
factorial 0 = 1
factorial n | n > 0 = n * factorial (n-1)

--d
--cantDivisoresPrimos :: Int -> Int
--cantDivisoresPrimos



valorAbsolutoInt :: Int -> Int
valorAbsolutoInt x | x >= 0 = x
                | otherwise = -x

esDivisor :: Int -> Int -> Bool
esDivisor a b | mod a (valorAbsolutoInt b) == 0 = True
              | otherwise = False
              
esPrimoAux :: Int -> Int -> Bool
esPrimoAux _ 1 = True
esPrimoAux a b = not(esDivisor a b) && esPrimoAux a (b-1)

esPrimo :: Int -> Bool
esPrimo n | n <= 1 = False
esPrimo n | n == 2 = True
          | otherwise = esPrimoAux n (n-1)

--ejercicio 3
--a
inverso :: Float -> Maybe Float
inverso n | n == 0 = Nothing
          | otherwise = Just (1/n)

--b
aEntero :: Either Int Bool -> Int
aEntero (Left n) = n
aEntero (Right b) | not b = 0
                  | b = 1

--ejercicio 4
--a
pertenece :: String -> Char -> Bool
pertenece [] _ = False
pertenece [x] c = x == c
pertenece (x:xs) c = x == c || pertenece xs c

limpiarAux :: String -> String -> String -> String
limpiarAux a [] c = c
limpiarAux a (x:xs) c | pertenece a x = limpiarAux a xs c
                      | otherwise = limpiarAux a xs (c ++ [x])

limpiar :: String -> String -> String
limpiar [] s = s
limpiar a b = limpiarAux a b []

--b
promGeneralAux :: [Float] -> Float -> Float -> Float
promGeneralAux [x] s c = (s+x)/(c+1)
promGeneralAux (x:xs) s c = promGeneralAux xs (s+x) (c+1)

promGeneral :: [Float] -> Float
promGeneral [] = 0
promGeneral [x] = x
promGeneral (x:xs) = promGeneralAux (x:xs) 0 0

difPromedioAux :: [Float] -> [Float] -> Float -> [Float]
difPromedioAux [x] b p = b ++ [x-p]
difPromedioAux (x:xs) b p = difPromedioAux xs (b ++ [x-p]) p

difPromedio :: [Float] -> [Float]
difPromedio [x] = [0]
difPromedio (x:xs) = difPromedioAux (x:xs) [] (promGeneral (x:xs))

--c
todosIguales :: [Int] -> Bool
todosIguales [] = True
todosIguales [x] = True
todosIguales (x:xs) = x == head(xs) && todosIguales xs

--ejercicio 5
data AB a = Nil | Bin (AB a) a (AB a)
    deriving (Show, Eq)
--a
vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB (Bin {}) = False

--b
negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin Nil x Nil) = Bin Nil (not x) Nil
negacionAB (Bin y x Nil) = Bin (negacionAB y) (not x) Nil
negacionAB (Bin Nil x z) = Bin Nil (not x) (negacionAB z)
negacionAB (Bin y x z) = Bin (negacionAB y) (not x) (negacionAB z)

--version corta
negacionAB2 :: AB Bool -> AB Bool
negacionAB2 Nil = Nil
negacionAB2 (Bin izq x der) = Bin (negacionAB izq) (not x) (negacionAB der)

--c
productoABAux:: AB Int -> Int -> Int
productoABAux Nil p = p
productoABAux (Bin izq x der) p = x * productoABAux izq 1 * productoABAux der 1

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin izq x der) = productoABAux (Bin izq x der) x