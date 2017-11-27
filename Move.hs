module Move where

import Types


-- create fun: anyMovesLeft that checks all cups for remaining marbles
-- do so for seperate player, ie, if player 1 has 2 marbles and player 2
-- has zero, p1 goes, then check again and etc..
move :: Board -> Int -> Board 
move (p, tiles) i 
    | 0 > i = error "invalid index, out of range"
    | 0 == 1 = error "invalid index, called on mancala"
    | 13 < i = error "invalid index, out of range"
    | 7 == i = error "invalid index, called on mancala"
    | otherwise = 
        let (Cup p_c ind m i_o) = tiles !! i in 
        if (p_c /= p) 
            then error "invalid: selected opponent's cup"
            else if (m <= 0)
                then error "invalid: zero marbles in cup"
                else 
                    (p, tiles)