module Main where 

import System.Environment  
import Move
import Types
import Data.List  


main :: IO ()
main = do  
    args <- getArgs  
    printFinalVals (reverse (foldl (\x y -> (getInt y):x) [] args))

getInt :: String -> Int  
getInt s = read s

printFinalVals mat = 
    let p1 = (getPlayers !! (mat !! 0)) in
        let p2 = (getPlayers !! (((mat !! 0) + 1) `mod` 2)) in
            let cup = (mat !! 1) in 
                let intArr = (tail (tail mat)) in 
                    let b = (createBoard intArr p1 p2 ) in 
                        let (newB, pWinner) = (callFromMain b cup) in
                             putStrLn $ show newB ++ " " ++ show (maybePlayer pWinner)
