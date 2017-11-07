\begin{code}

module Move where
import Prelude 

addToList :: Int -> Int -> [Int] -> [Int]
addToList index 0 lst = lst
addToList index marbles lst = 
	let nextIndex = ((index + 1) `mod` 14) in
		let newList =  (replaceInList nextIndex ((lst !! nextIndex) + 1) lst) in
			let newMarbles = (marbles - 1) in
				addToList nextIndex newMarbles newList


replaceInList :: Int -> Int -> [Int] -> [Int]
replaceInList 0 val lst = 
	([val] ++ (drop 1 lst))
replaceInList index val (x:xs) = 
	[x] ++ (replaceInList (index - 1) val xs)


move :: Int -> Int -> [Int] ->  (Int, [Int])
move p pos lst = let marbles_at_pos = lst !! pos in 
	let realIndex = (pos `mod` 14) in
		let newList = addToList realIndex marbles_at_pos lst in
			(if (p == 0)
				then (if ((pos + marbles_at_pos) `mod` 14 == 0)
					then (p, ((take (realIndex) newList) ++ [0] ++ (drop (realIndex+1) newList)))
					else ( (p + 1) `mod` 2, ((take (realIndex) newList) ++ [0] ++ (drop (realIndex+1) newList))))
				else ( (p + 1) `mod` 2, ((take (realIndex) newList) ++ [0] ++ (drop (realIndex+1) newList))))




\end{code}
