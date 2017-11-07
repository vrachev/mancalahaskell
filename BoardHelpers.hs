module BoardHelpers where

putIntoTwo :: Int -> String
putIntoTwo n = if n < 10 then (show n) ++ " " else show n 

if' :: Bool -> a -> a -> a
if' True  x _ = x
if' False _ y = y