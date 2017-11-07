\begin{code}

module Move where
import Prelude 


addToList :: Int -> Int -> [Int] -> [Int]
addToList index 0 lst = lst
addToList index marbles lst = 
	let nextIndex = ((index + 1) `mod` 14) in
		let newList = ((take nextIndex lst) ++ [(lst !! (nextIndex)) + 1] ++ (drop (nextIndex + 1) lst)) in
			let newMarbles = (marbles - 1) in
				addToList nextIndex newMarbles newList

move :: Int -> Int -> [Int] -> [Int]
move p pos lst = let marbles_at_pos = lst !! pos in 
	let newList = addToList pos marbles_at_pos lst in
		 ((take (pos - 1) newList) ++ [0] ++ (drop (pos+1) newList))


	--(if (p == 0)
	--then (if ((pos + marbles_at_pos) `mod` (length lst) == 0)
	--	then [1] else [2])
	--else (if ((pos + marbles_at_pos) `mod` (length lst) == 7)
	--	then [1] else [2]))

\end{code}
