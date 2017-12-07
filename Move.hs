module Move where

import Types
import Debug.Trace


-- create fun: anyMovesLeft that checks all cups for remaining marbles
-- do so for seperate player, ie, if player 1 has 2 marbles and player 2
-- has zero, p1 goes, then check again and etc..

-- main Move function: checks output, sends correct output to helper
-- i is the index of the cup from which a player wants to move marbles
move :: Board -> Int -> Board
move (p, tiles) i
    | 0 > i = returnSameBoard (p, tiles)
    | 0 == i = returnSameBoard (p, tiles)
    | 13 < i = returnSameBoard (p, tiles)
    | 7 == i = returnSameBoard (p, tiles)
    | otherwise =
        let (Cup p_c ind m i_o) = tiles !! i in
        if (p_c /= p)
            then returnSameBoard (p, tiles)
            else if (m <= 0)
                then returnSameBoard (p, tiles)
                else moveCorrectInput (p, tiles) i


returnSameBoard :: Board -> Board 
returnSameBoard b = b

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
    let (Cup p_c i m i_o) = tiles !! index in
        trace ("doWeTakeOppMarb ind: " ++ show index ++ "  " ++ show p_c)
        ((if (isThisPlayersCup (Cup p_c i m i_o) p == False) then False
            else if (isCupEmpty (Cup p_c i m i_o) == True) then True else False))




-- Int - index of tile where last marble went to

takeOpponentMarblesAndUpdateBoard :: Board -> Int -> [Tile]
takeOpponentMarblesAndUpdateBoard (p, tiles) i =
    let playerMancala = getPlayerMancala p tiles in
        trace ("takeOpponent board: " ++ show (p, tiles))
        (let currentTile = (tiles !! i) in
            (trace "hmm")
            (let (Mancala p_m i_mancala m_mancala) = playerMancala in
                let (Cup p1 i1 m1 i_o ) = (tiles !! i) in
                    let (Cup p2 i2 m2 i_o2) = (tiles !! i_o) in
                        let newMancala = incrementMarbleCountByNum playerMancala m2 in
                            trace ("manca_p: " ++ show p)
                            (let newTileList = updateTile tiles i_mancala newMancala in
                                let newTileList1 = updateTile newTileList i2 (Cup p2 i2 0 i_o2) in 
                                    trace ("takeOpponent finalboard: " ++ show (p, newTileList1)) (newTileList1))))
                                


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
returnFinalBoardAndNextPlayer (p, tiles) (p_before, tiles_before) ind =
    if (didLastMarbleLandInMancala (playerIndex p) ind) == True then (p, tiles) else
        if (doWeTakeOpponentMarbles (p_before, tiles_before) ind) == False then ((getNextPlayer p), tiles) else
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
