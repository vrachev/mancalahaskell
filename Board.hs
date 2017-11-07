module Main where

import BoardHelpers
import Move
import Control.Monad

printBoard:: [Int] -> IO ()
printBoard board = do
    putStrLn "----13-12-11-10-9--8--P2-"
    putStrLn ("|  |"++putIntoTwo (board !! 13)++"|"++putIntoTwo 
    	(board !! 12)++"|"++putIntoTwo (board !! 11)++"|"++putIntoTwo (board !! 10)++"|"++
    	putIntoTwo (board !! 9)++"|"++putIntoTwo (board !! 8)++"|  |") 
    putStrLn ("|"++ putIntoTwo (board !! 0) ++" ----------------- "++ putIntoTwo (board !! 7) ++"|")		
    putStrLn ("|  |"++putIntoTwo (board !! 1)++"|"++putIntoTwo 
    	(board !! 2)++"|"++putIntoTwo (board !! 3)++"|"++putIntoTwo (board !! 4)++"|"++
    	putIntoTwo (board !! 5)++"|"++putIntoTwo (board !! 6)++"|  |") 
    putStrLn "-P1-1--2--3--4--5--6-----"	

main :: IO()
main = do
    let board = [0,4,4,4,4,4,4,0,4,4,4,4,4,4]
    playGame board

playGame :: [Int] -> IO ()
playGame board = do
	printBoard board
	putStrLn "Player 1's Move! Enter a number to choose a pit!"
	daMove <- getLine
	board <- return (move 0 (read daMove) board)
--	checkwin
	printBoard board
	putStrLn "Player 2's Move! Enter a number to choose a pit!"
	daMove2 <- getLine
	board <- return (move 1 (read daMove2) board)
--checkWin	
	playGame board
