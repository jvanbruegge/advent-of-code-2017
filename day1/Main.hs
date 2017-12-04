module Main where

circular :: String -> Int -> Char
circular s x = if x >= len then circular s (x - len) else s !! x
    where len = length s

isNewline :: Char -> Bool
isNewline = (==) '\n'

test :: (Int -> Char) -> (Int -> Int) -> Int -> Int
test get offset x = if get x == get (offset x) then read [get x] else 0

testCommon :: (Int -> Int) -> String -> Int
testCommon test input = foldl (+) 0 $
        fmap test $
        [0..((length input) - 1)]

main = do
    input <- fmap (filter (not . isNewline)) $ readFile "input.txt"
    let check = test $ circular input

    let result1 = testCommon (check (+1)) input
    putStrLn ("Part 1: Result is " ++ show result1)

    let result2 = testCommon (check (+(length input `div` 2))) input
    putStrLn ("Part 2: Result is " ++ show result2)
