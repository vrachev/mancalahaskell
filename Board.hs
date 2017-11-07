module Main where

import BoardHelpers
import Control.Monad
--takes list of board  and prints it
checkWin :: [Int] -> Bool
checkWin board = True

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
	move <- getLine
--	board <- return board
--	when (checkWin board) return "Winner!"
	printBoard board
	putStrLn "Player 2's Move! Enter a number to choose a pit!"
	move <- getLine
	putStrLn (show move)
	playGame board
--	board <- return board
	--if(checkWin board) then (return "Winner!") else (playGame board)
