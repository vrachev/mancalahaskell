module Types where

import qualified Data.List

data Player = 
    Player { playerName :: String }

-- Cup Player IndexOnBoard MarblesInCup IndexOpposing
-- Mancala Player IndexOnBoard MarblesInMancala 
-- IndexOpposing refers to when your Cup has 0 marbles 
-- and you end in it
-- therefore taking all the marbles of the opposing Cup
data Tile = Cup Player Int Int Int
          | Mancala Player Int Int 


-- Player is the next Player to move
-- [Tile] is the board 
type Board = (Player, [Tile])

data Dimension = Dim Int 

startBoard :: Player -> Player -> Board
startBoard p1 p2 = (p1, [
    (Mancala p2 0 0),
    (Cup p1 1 4 13),
    (Cup p1 2 4 12),
    (Cup p1 3 4 11),
    (Cup p1 4 4 10),
    (Cup p1 5 4 9),
    (Cup p1 6 4 8),
    (Mancala p1 7 0),
    (Cup p2 8 4 6),
    (Cup p2 9 4 5),
    (Cup p2 10 4 4),
    (Cup p2 11 4 3),
    (Cup p2 12 4 2),
    (Cup p2 13 4 1)
    ])


isCupEmpty :: Tile -> Bool
isCupEmpty (Cup _ _ 0 _) = True
isCupEmpty (Cup _ _ _ _) = False
isCupEmpty (Mancala _ _ _) = error "Only call on cups, not mancala"

updateMarbleCount :: Tile -> Tile
updateMarbleCount (Cup p i marbles o)  = Cup p i (marbles + 1) o
updateMarbleCount (Mancala p i marbles)  = Mancala p i (marbles + 1)

resetToZero :: Tile -> Tile
resetToZero (Cup p i marbles o) = Cup p i 0 o
resetToZero (Mancala p i marbles) = Mancala p i 0 

marblesInTile :: Tile -> Int
marblesInTile (Cup _ _ n _) = n
marblesInTile (Mancala _ _ n) = n 

-- method that replaces a bucket in the board with a new count of marbles
-- [Tile] - input tiles
-- Int - index to replace
-- Tile - tile to replace
-- Bool - true if incrementing Tile, false if resetting to zero
-- [Tile] - output tiles      
updateTile :: [Tile] -> Int -> Tile -> Bool -> [Tile]
updateTile tiles 0 t True = 
    let updatedTile = updateMarbleCount t  in
        let newTileList = ([updatedTile] ++ (drop 1 tiles)) in
        newTileList
updateTile tiles 0 t False = 
    let updatedTile = resetToZero t in
        let newTileList = ([updatedTile] ++ (drop 1 tiles)) in
        newTileList
updateTile (x:xs) index t b = 
    [x] ++ (updateTile xs (index - 1) t b)
       



instance Show Player where
    show = playerName

instance Eq Player where
    p1 == p2 = playerName p1 == playerName p2

instance Show Tile where
    show (Cup a b c d) = show c
    show (Mancala a b c) = show c






