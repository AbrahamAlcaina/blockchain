module GettingStartedSpec (spec) where

import           SpecHelper

spec :: Spec
spec =
    describe "Base case to  configure hspec" $
        prop "shoud be equal" $ \x y ->
            add x y == add y x

add :: Int -> Int -> Int
add x y = x + y
