module Tests where 

import Types 
import Move 


getBoards :: [[Int]] -> Player -> Player -> [Board]
getBoards [] _ _  = []
getBoards (x:xs) p1 p2 = (createBoard x p1 p2):(getBoards xs p1 p2)

players :: [Player]
players = initPlayers "p1" "p2"

boardArraysP2 :: [[Int]] 
boardArraysP2 = [[0,4,4,4,4,4,4,0,4,4,4,4,4,4], -- check valid/invalid moves on standard board
               [4,0,0,0,0,0,0,5,0,0,0,0,0,0], -- no moves possible, game over
               [4,0,0,0,0,0,0,4,0,0,0,0,0,1], -- p2 has one move left, everything else should error, p2 wins after
               [4,0,0,0,0,0,0,4,0,0,0,0,2,1], -- p2 moves, after this p1 has no moves so it should default back to p2
               [0,4,4,4,4,4,4,0,4,4,4,4,4,4], -- p2 moves, lands in own mancala, goes again (move b 10)
               [0,4,4,4,4,4,4,0,4,4,4,4,4,4]] -- p2 moves, lands in own cup with 0 marbles, reaps opposing cup, p1 goes              


-- boards with it being P2's turn
boards :: [Board]
boards = getBoards boardArraysP2 (players !! 1) (players !! 0)



-- returns true if two boards are equal
boardEqual :: Board -> Board -> Bool
boardEqual (pfirst, tiles1) (psecond, tiles2) = if ((pfirst == psecond) && (tilesEqual tiles1 tiles2)) then True else False
