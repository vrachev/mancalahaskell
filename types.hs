module Types where

import qualified Data.List

data Player = 
    Player { playerName :: String }

-- Cup Player IndexOnBoard MarblesInCup 
-- Mancala Player IndexOnBoard MarblesInMancala 
data Tile = Cup Player Int Int 
          | Mancala Player Int Int 

-- data NextPlayerTurn = NextPlayerTurn { player :: Player }

type Board = [Tile]

-- data Board = Board { next :: NextPlayerTurn
 --                  , cups :: List Cup }


isCupEmpty :: Tile -> Bool
isCupEmpty (Cup _ _ 0) = True
isCupEmpty (Cup _ _ _) = False
isCupEmpty (Mancala _ _ _) = error "Only call on cups, not mancala"

marblesInTile :: Tile -> Int
marblesInTile (Cup _ _ n) = n
marblesInTile (Mancala _ _ n) = n 

instance Show Player where
    show = playerName







