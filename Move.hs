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
            let updatedTiles = (updateTile tiles nextIndex currentTile True)
                in updatePlusOne updatedTiles nextIndex marblesRemaining


-- updates boar with new marble counts
-- Board : input board
-- Int : index of cup chosen
-- Board : output board
updateBoard :: Board -> Int -> Board
updateBoard (p, tiles) index = 
    let marbles = marblesInTile (tiles !! index) in
        let updatedTiles = updatePlusOne tiles index marbles in
            let newListAndRestorigTile = updateTile updatedTiles index (tiles !! index) False in
                (p, newListAndRestorigTile)


-- updatePlayer :: Board -> Int -> Board

-- moveCorrectOutput is the move method but with input guaranteed to be correct
moveCorrectInput :: Board -> Int -> Board
moveCorrectInput (p, tiles) i = 
    let (Cup p_c ind m i_o) = tiles !! i in
        let updatedBoard = updateBoard (p, tiles) i in
            updatedBoard




