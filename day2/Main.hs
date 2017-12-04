module Main where

calculateRow :: ([Int] -> Int) -> String -> Int
calculateRow sum = sum . fmap read . words

checksum1 :: [Int] -> Int
checksum1 list = maximum list - minimum list

checksum2 :: [Int] -> Int
checksum2 list = head [x `div` y | x <- list, y <- list, x `mod` y == 0, x /= y]

calc :: ([Int] -> Int) -> [String] -> Int
calc check = foldl (+) 0 . fmap (calculateRow check)

main = do
    input <- fmap (filter (not . null)) $
            fmap lines $ readFile "input.txt"

    let result1 = calc checksum1 input
    putStrLn ("Part 1: Result is " ++ show result1)

    let result2 = calc checksum2 input
    putStrLn ("Part 2: Result is " ++ show result2)
