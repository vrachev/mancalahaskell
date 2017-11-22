module Types where

import qualified Data.List

data Player = 
    Player { playerName :: String }

data Cup p m = Cup { player :: Player
                   , marbles :: Int }

isCupEmpty :: (Cup a b) -> Bool
isCupEmpty (Cup _ 0) = True
isCupEmpty (Cup _ _) = False


