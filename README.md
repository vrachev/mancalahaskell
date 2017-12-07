# mancalahaskell
A Haskell Mancala Game

Project By Vlad Rachev and Marc Eastman

![](/mancala.jpg?raw=true "Mancala")

Installation:
 * npm install mancalahaskell
 * npm start

Runs a mancala game for 2 human players.
 * uses node.js to run haskell executable
 * bottom/right is player 1, top/left is player 2

Rules
 * If you land in your own mancala (side hole) you go again
 * If you land in an empty hole on your side, steal opponent's marbles
 * When all marbles are gone from the holes, whoever has more wins
