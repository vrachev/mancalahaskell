module Types where

import qualified Data.List

data Player = 
    Player { playerName :: String,
             playerIndex :: Int}

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

initPlayers :: String -> String -> [Player]
initPlayers s0 s1 = 
    let p0 = Player s0 0 
        p1 = Player s1 1 in [p0, p1]

getPlayers :: [Player]
getPlayers = initPlayers "player0" "player1"


isCupEmpty :: Tile -> Bool
isCupEmpty (Cup _ _ 0 _) = True
isCupEmpty (Cup _ _ _ _) = False
isCupEmpty (Mancala _ _ _) = error "Only call on cups, not mancala"

updateMarbleCount :: Tile -> Tile
updateMarbleCount (Cup p i marbles o)  = Cup p i (marbles + 1) o
updateMarbleCount (Mancala p i marbles)  = Mancala p i (marbles + 1)

incrementMarbleCountByNum :: Tile -> Int -> Tile
incrementMarbleCountByNum (Mancala p i marbles) num = Mancala p i (marbles + num)
incrementMarbleCountByNum (Cup p i marbles o) num = (Cup p i (marbles + num) o)

resetToZero :: Tile -> Tile
resetToZero (Cup p i marbles o) = Cup p i 0 o
resetToZero (Mancala p i marbles) = Mancala p i 0 

isThisPlayersCup :: Tile -> Player -> Bool
isThisPlayersCup (Cup p _ _ _) p2 = if p == p2 then True else False
isThisPlayersCup (Mancala _ _ _) _ = False

marblesInTile :: Tile -> Int
marblesInTile (Cup _ _ n _) = n
marblesInTile (Mancala _ _ n) = n 

getNextPlayer :: Player -> Player
getNextPlayer p = if ((playerIndex p) == 0) then (getPlayers !! 1) else (getPlayers !! 0)

getPlayerMancala :: Player -> [Tile] -> Tile
getPlayerMancala p tiles = if ((playerIndex p) == 0) then (tiles !! 7) else (tiles !! 0)


-- method that replaces a bucket in the board with a new count of marbles
-- [Tile] - input tiles
-- Int - index to replace
-- Tile - tile to replace
-- Tile - tile to replace with
-- [Tile] - output tiles      
updateTile :: [Tile] -> Int -> Tile -> [Tile]
updateTile tiles 0 newT = 
    let newTileList = ([newT] ++ (drop 1 tiles)) in
        newTileList
updateTile (x:xs) index b = 
    [x] ++ (updateTile xs (index - 1) b)
       



instance Show Player where
    show = playerName

instance Eq Player where
    p1 == p2 = playerIndex p1 == playerIndex p2

instance Show Tile where
    show (Cup a b c d) = show c
    show (Mancala a b c) = show c






