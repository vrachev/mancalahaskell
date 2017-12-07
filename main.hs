module Main where

import System.Environment
import System.Exit
import Move
import Types
import Data.List


main :: IO ()
main = do
    args <- getArgs
    printFinalVals (reverse (foldl (\x y -> (getInt y):x) [] args))
    exitWith ExitSuccess

getInt :: String -> Int
getInt s = read s

printFinalVals :: [Int] -> IO ()
printFinalVals mat =
    let p1 = (getPlayers !! (mat !! 0)) in
        let p2 = (getPlayers !! (((mat !! 0) + 1) `mod` 2)) in
            let cup = (mat !! 1) in
                let intArr = (tail (tail mat)) in
                    let b = (createBoard intArr p1 p2 ) in
                        let (newB, pWinner) = (callFromMain b cup) in
                             putStr $ show (maybePlayer pWinner) ++ " " ++ show newB 
