module Tests where 

import Types 
import Move 


getBoards :: [[Int]] -> Player -> Player -> [Board]
getBoards [] _ _  = []
getBoards (x:xs) p1 p2 = (createBoard x p1 p2):(getBoards xs p1 p2)

players :: [Player]
players = initPlayers "p1" "p2"

boardArraysP1 :: [[Int]] 
boardArraysP1 = [[0,4,4,4,4,4,4,0,4,4,4,4,4,4], -- check valid moves on standard board
               [4,0,0,0,0,0,0,5,0,0,0,0,0,0], -- no moves possible, game over
               [4,0,0,0,0,0,1,4,0,0,0,0,0,0], -- p1 has one move left, p1 wins after
               [0,4,4,4,4,0,4,0,4,4,4,4,4,4], -- p1 moves, lands in own cup with 0 marbles, reaps opposing cup, p1 goes
               [0,4,4,4,4,4,4,0,4,4,4,4,4,4]] -- p1 lands in own mancala, goes again

boardsArrayP1Correct :: [[Int]]
boardsArrayP1Correct = [[0,0,5,5,5,5,4,0,4,4,4,4,4,4], -- check valid moves on standard board 1
               [4,0,0,0,0,0,0,5,0,0,0,0,0,0], -- no moves possible, game over 6
               [4,0,0,0,0,0,0,5,0,0,0,0,0,0], -- p1 has one move left, p1 wins after  6
               [0,0,5,5,5,1,4,4,4,0,4,4,4,4], -- p1 moves, lands in own cup with 0 marbles, reaps opposing cup, p1 goes 1
               [0,4,4,0,5,5,5,1,4,4,4,4,4,4]] -- p1 lands in own mancala, goes again 3 

-- boards with it being P2's turn
boards :: [[Int]] -> Int -> Int -> [Board]
boards ints i1 i2= getBoards ints (players !! i1) (players !! i2)



-- returns true if two boards are equal
boardEqual :: Board -> Board -> Bool
boardEqual (pfirst, tiles1) (psecond, tiles2) = if (tilesEqual tiles1 tiles2) then True else False


boardsEqual :: [Board] -> [Board] -> [Int] -> Bool 
boardsEqual [] [] [] = True 
boardsEqual (bIn:restIn) (bOut:restOut) (firstMove:restMoves)= if (boardEqual (move bIn firstMove) bOut) then boardsEqual restIn restOut restMoves else False

runTests :: Bool 
runTests = 
    let bIns = (boards boardArraysP1 0 1)
        bOuts = (boards boardsArrayP1Correct 1 0)
        moves = [1,6,6,1,3]
        in boardsEqual bIns bOuts moves