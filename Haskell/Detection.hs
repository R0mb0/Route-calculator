module Detection where
import GHC.Float
import GHC.Num

{-****Defining the Functions to work with detection****-}

{- Split the longitude string part-}
spl :: String -> String 
spl = drop 17 

{-Get the latitude tupla from the string-}
getLatitude :: String -> (Char, Int, Int, Float)
getLatitude st = (head st, read(take 2 (drop 2 st)) :: Int, read(drop 5 (take 7 st)) :: Int, read(drop 8 (take 14 st)) :: Float)

{-Get the longitude tupla from the string-}
getLongitude :: String -> (Char, Int, Int, Float)
getLongitude st = (head (spl st), read(take 2 (drop 2 (spl st))) :: Int, read(drop 5 (take 7 (spl st))) :: Int, read(drop 8 (take 14 (spl st))) :: Float)

{-Verify if the latitude & the longitude are real-}
verify :: (Char, Int, Int, Float) -> Bool 
verify (s, x, y, z) 
                    | x < 0 && x > 90 && y < 0 && y > 59 && z < 0 && z > 59 = False 
                    | s == 'N' = True
                    | s == 'S' = True 
                    | s == 'E' = True
                    | s == 'W' = True 
                    | otherwise = False 
     
{-Convert the coordinate in decimal format-}
convertToDecimal :: (Char, Int, Int , Float ) -> Double  
convertToDecimal (s, x, y, z) 
                            | s == 'S' || s == 'W' = float2Double (((((z / 60) + fromIntegral y) / 60) + fromIntegral x) * (-1))
                            | otherwise = float2Double ((((z / 60) + fromIntegral y) / 60) + fromIntegral x)

{-Create a merger in way to have the latitude & the longitude toghether-}
merge :: a -> a -> [a]
merge lat long = [lat, long]

{-Functions to get from the input string the decimal point-}
getPoint :: String -> [Double]
getPoint st = 
    if verify (getLatitude st) && verify (getLongitude st) 
        then merge (convertToDecimal(getLatitude st)) (convertToDecimal(getLongitude st))
        else []
