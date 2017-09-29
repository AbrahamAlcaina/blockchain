module ChainSpec (spec) where

import           Chain
import           SpecHelper

spec::Spec
spec =
    describe "Block Chain" $
        it "Generate genesis block" $ do
            getIndex gb `shouldBe` 0
            getPreviousHash gb `shouldBe` ""
            where gb = genesisBlock

