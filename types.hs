module Types where

import qualified Data.List

data Player = 
    Player { playerName :: String }

-- Cup Player IndexOnBoard MarblesInCup 
-- Mancala Player IndexOnBoard MarblesInMancala IndexOpposing
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

marblesInTile :: Tile -> Int
marblesInTile (Cup _ _ n _) = n
marblesInTile (Mancala _ _ n) = n 

instance Show Player where
    show = playerName

instance Eq Player where
	p1 == p2 = playerName p1 == playerName p2

instance Show Tile where
    show (Cup a b c d) = show c
    show (Mancala a b c) = show c






