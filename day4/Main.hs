module Main where

import qualified Data.Set as S
import Data.List (sort)

calculate :: ((Bool, S.Set String) -> String -> (Bool, S.Set String)) -> [String] -> Int
calculate fn input = foldl (+) 0 $
            fmap (\(b, _) -> if b then 1 else 0) $
            fmap (foldl fn (True, S.empty) . words) input

main = do
    input <- fmap (filter (not . null)) $
            fmap lines $ readFile "input.txt"

    let result1 = calculate entropy1 input
    putStrLn ("Part 1: Result is " ++ show result1)

    let result2 = calculate entropy2 input
    putStrLn ("Part 2: Result is " ++ show result2)

entropy1 :: (Bool, S.Set String) -> String -> (Bool, S.Set String)
entropy1 (b, s) word = if S.member word s then (False, s) else (b, S.insert word s)

entropy2 :: (Bool, S.Set String) -> String -> (Bool, S.Set String)
entropy2 (b, s) word = if S.member sorted s
        then (False, s)
        else (b, S.insert sorted s)
    where sorted = sort word
