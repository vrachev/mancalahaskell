module Types where

import qualified Data.List

data Player = 
    Player { playerName :: String }

data Cup p i m= Cup { player :: Player
                   , cupIndex :: Int
                   , marbles :: Int }

isCupEmpty :: (Cup p i m) -> Bool
isCupEmpty (Cup _ _ 0) = True
isCupEmpty (Cup _ _ _) = False

marblesInCup :: (Cup p i m) -> Int
marblesInCup (Cup _ _ n) = n

instance Show Player where
    show = playerName







