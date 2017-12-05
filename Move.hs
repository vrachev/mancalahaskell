module Move where

import Types


-- create fun: anyMovesLeft that checks all cups for remaining marbles
-- do so for seperate player, ie, if player 1 has 2 marbles and player 2
-- has zero, p1 goes, then check again and etc..

-- main Move function: checks output, sends correct output to helper
-- i is the index of the cup from which a player wants to move marbles
move :: Board -> Int -> Board 
move (p, tiles) i 
    | 0 > i = error "invalid index, out of range"
    | 0 == i = error "invalid index, called on mancala"
    | 13 < i = error "invalid index, out of range"
    | 7 == i = error "invalid index, called on mancala"
    | otherwise = 
        let (Cup p_c ind m i_o) = tiles !! i in 
        if (p_c /= p) 
            then error "invalid: selected opponent's cup"
            else if (m <= 0)
                then error "invalid: zero marbles in cup"
                else moveCorrectInput (p, tiles) i
  
finalBoardAndWinner :: Board -> (Board, Maybe Player)
finalBoardAndWinner (p, tiles) = 
    if (checkIfGameOver tiles == True) 
        then ((p, tiles), Just (returnWinner tiles)) 
        else ((p, tiles), Nothing)

callFromMain :: Board -> Int -> (Board, Maybe Player)
callFromMain b i = (finalBoardAndWinner (move b i))



-- increments the next I cups by one
-- [Tiles] : input tile list
-- Int : startIndex - does not update this one, this is reset to 0 by calling function
-- Int : marbles to distribute
-- [Tiles] : output tile list
updatePlusOne :: [Tile] -> Int -> Int -> [Tile]
updatePlusOne tiles index 0 = tiles
updatePlusOne tiles index marbles = 
    let nextIndex = ((index + 1) `mod` 14) in
        let currentTile = (tiles !! nextIndex)
            marblesRemaining = (marbles - 1)
            in 
            let updatedTiles = (updateTile tiles nextIndex (updateMarbleCount currentTile))
                in updatePlusOne updatedTiles nextIndex marblesRemaining


-- updates board with new marble counts
-- Board : input board
-- Int : index of cup chosen
-- Board : output board
updateBoard :: Board -> Int -> Board
updateBoard (p, tiles) index = 
    let marbles = marblesInTile (tiles !! index) in
        let updatedTiles = updatePlusOne tiles index marbles in
            let newListAndRestorigTile = updateTile updatedTiles index (resetToZero (tiles !! index)) in
                (p, newListAndRestorigTile)


-- int : playerIndex 
-- int : index of last cup
didLastMarbleLandInMancala :: Int -> Int -> Bool
didLastMarbleLandInMancala 1 0 = True
didLastMarbleLandInMancala 0 7 = True
didLastMarbleLandInMancala _ _ = False


doWeTakeOpponentMarbles :: Board -> Int -> Bool
doWeTakeOpponentMarbles (p, tiles) index =
    let t = tiles !! index in
        if (isThisPlayersCup t p == False) then False 
            else if (isCupEmpty t == True) then True else False


-- Int - index of tile where last marble went to 
 
takeOpponentMarblesAndUpdateBoard :: Board -> Int -> [Tile]
takeOpponentMarblesAndUpdateBoard (p, tiles) i = 
    let playerMancala = getPlayerMancala p tiles in
        let currentTile = (tiles !! i) in
            let (Cup p_c i_cup m i_o) = currentTile in 
                let (Mancala p_c i_mancala m_mancala) = playerMancala in 
                    let tileToReset = (tiles !! i_o) in 
                        let newT = incrementMarbleCountByNum playerMancala m in 
                            let newTileList = updateTile tiles i_mancala newT in 
                                let tileListWithReset = updateTile newTileList i_o (resetToZero tileToReset) in 
                                    tileListWithReset 


checkIfGameOver :: [Tile] -> Bool
checkIfGameOver [] = True
checkIfGameOver (x:xs) = 
    if (isACup x == False) then checkIfGameOver xs
        else if ((marblesInTile x) /= 0) then False
            else checkIfGameOver xs

-- returns winner
-- only call if checkIfGameOver == true
returnWinner :: [Tile] -> Player
returnWinner tiles = 
    let mancalaP1 = (tiles !! 0) 
        mancalaP2 = (tiles !! 1) 
        in if (marblesInTile mancalaP1) > (marblesInTile mancalaP2) 
               then let (Mancala p _ _) = mancalaP1 in p
               else let (Mancala p _ _) = mancalaP2 in p



-- Board - input board
-- Board - startingBoard (to check if take over should happen)
-- Int - index of tile where last marble went to
returnFinalBoardAndNextPlayer :: Board -> Board -> Int -> Board
returnFinalBoardAndNextPlayer (p, tiles) (_, tilesNext) ind = 
    if (didLastMarbleLandInMancala (playerIndex p) ind) == True then (p, tiles) else
        if (doWeTakeOpponentMarbles (p, tilesNext) ind) == False then ((getNextPlayer p), tiles) else 
            let finalTiles = (takeOpponentMarblesAndUpdateBoard (p, tiles) ind) in 
                ((getNextPlayer p), finalTiles)


-- updatePlayer :: Board -> Int -> Board 
-- updatePlayer (p, tiles) index 


-- moveCorrectOutput is the move method but with input guaranteed to be correct
moveCorrectInput :: Board -> Int -> Board
moveCorrectInput (p, tiles) i = 
    let (Cup p_c ind m i_o) = tiles !! i in
        let updatedBoard = updateBoard (p, tiles) i in
            returnFinalBoardAndNextPlayer updatedBoard (p, tiles) (getEndBucketIndex tiles i) 
            

-- retrieves index of the bucket where the last marble will fall
-- Int - index of start bucket
getEndBucketIndex :: [Tile] -> Int -> Int
getEndBucketIndex tiles ind = 
    let m = marblesInTile (tiles !! ind) in 
        (ind + m) `mod` 14



