import GHC.Base (DoubleBox)
import Control.Arrow (ArrowZero(zeroArrow))


data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: (b -> a -> b -> b) -> b -> AB a -> b
foldAB f z Nil = z
foldAB f z (Bin i r d) = f (rec i) r (rec d)
    where rec = foldAB f z

recAB :: (AB a -> b -> a -> AB a -> b -> b) -> b -> AB a -> b
recAB f z Nil = z
recAB f z (Bin i r d) = f i (rec i) r d (rec d)
    where rec = recAB f z

esNil :: AB a -> Bool
esNil a = case a of
    Nil -> True
    _ -> False

altura :: AB a -> Int
altura = foldAB (\rec1 x rec2 -> 1 + max rec1 rec2) 0

cantNodos :: AB a -> Int
cantNodos = foldAB (\rec1 x rec2 -> 1 + rec1 + rec2) 0
{- 
mejorSegún :: (a -> a -> Bool) -> AB a -> a
mejorSegún f a = case a of 

esABB :: Ord a => AB a -> Bool
esABB = recAB (\i reci r d recd -> )
-}
data Nave = Chasis Int | Propulsor (Int -> Float) Nave | Cabina Nave | Ensamblar Nave Nave

foldNave :: (Int -> b) -> ((Int -> Float) -> b -> b) -> (b -> b) -> (b -> b -> b) -> Nave -> b
foldNave fChas fProp fCab fEns nave = case nave of
    Chasis v -> fChas v
    Propulsor f n -> fProp f (rec n)
    Cabina n -> fCab (rec n)
    Ensamblar n1 n2 -> fEns (rec n1) (rec n2) 
    where rec = foldNave fChas fProp fCab fEns

recNave :: (Int -> b) -> ((Int -> Float) -> Nave -> b -> b) -> (Nave -> b -> b) -> (Nave -> b -> Nave -> b -> b) -> Nave -> b
recNave fChas fProp fCab fEns nave = case nave of
    Chasis v -> fChas v
    Propulsor f n -> fProp f n (rec n)
    Cabina n -> fCab n (rec n)
    Ensamblar n1 n2 -> fEns n1 (rec n1) n2 (rec n2) 
    where rec = recNave fChas fProp fCab fEns

energía :: Int -> Nave -> Float
energía k = foldNave (const 0) (\f rec -> f k + rec) id (+)

renovarChasis :: Int -> Int -> Nave -> Nave
renovarChasis k c = foldNave (\n -> if n<k then Chasis c else Chasis n) Propulsor Cabina Ensamblar

navesIguales :: Int -> Nave -> Nave -> Bool
navesIguales d = foldNave (\n n1 -> case n1 of 
                                        Chasis n2 -> if n < d then n2 < d else n2 >= d
                                        _ -> False) 
                        (\f rec n2 -> case n2 of
                                        Propulsor _ p -> rec p
                                        _ -> False)
                        (\rec n1 -> case n1 of
                            Cabina _ -> rec n1)
                        (\rec1 rec2 n2 -> case n2 of
                            Ensamblar _ _ -> rec1 n2 && rec2 n2
                            _ -> False)
{- 
apta :: Nave -> Bool
apta = foldNave (\n -> False) (\f rec -> rec) (\rec -> rec) (\rec1 rec2 -> rec1 && rec2)
-}

data HashSet a = Hash (a -> Integer) (Integer -> [a])
{-
vacio :: (a -> Integer) -> HashSet a
vacio = 
-}