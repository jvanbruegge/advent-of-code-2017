{-# LANGUAGE BangPatterns #-}

module Main where

import qualified Data.Map.Strict as M

main = do
    input <- fmap (filter (not . null)) $ lines <$> readFile "day5/input.txt"

    let map = insertLines input

    let result1 = doStep (+1) 0 0 map
    putStrLn $ "Part 1: Result is " ++ show result1

    let result2 = doStep increment2 0 0 map
    putStrLn $ "Part 2: Result is " ++ show result2

doStep :: (Int -> Int) -> Int -> Int -> M.Map Int Int -> Int
doStep incr !n !pc map = case M.lookup pc map of
        Nothing -> n
        Just x -> doStep incr (n + 1) (pc + x) (M.insert pc (incr x) map)


increment2 :: Int -> Int
increment2 prev = if prev >= 3 then prev - 1 else prev + 1

insertLines :: [String] -> M.Map Int Int
insertLines lines = helper 0 lines M.empty
    where helper n [] map = map
          helper n (x:xs) map = helper (n + 1) xs $ M.insert n (read x) map
