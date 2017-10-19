module ChainSpec (spec) where

import           Chain
import qualified Data.ByteString.Char8 as C
import           SpecHelper

spec::Spec
spec =
    describe "Feature: Blockchain" $
        describe "Given the user have a blockchain" $
            describe "When I have a genesisBlock"$ do
                it "Then It should have index 0" $
                    getIndex genesisBlock `shouldBe` 0
                it "And It should have an specific hash" $
                    getHash genesisBlock `shouldBe` getGenesisHash
                describe "When I create a new block" $ do
                    it "Then the previousHash Should be the genesis Hash" $
                        getPreviousHash (nextBlock genesisBlock time rawData) `shouldBe` getGenesisHash
                    it "Then the block have the time" $
                        getTimeStamp (nextBlock genesisBlock time rawData) `shouldBe` time
                    it "Then the block have the rawData" $
                        getRawData (nextBlock genesisBlock time rawData) `shouldBe` rawData
                    it "Then the block have index 1" $
                        getIndex (nextBlock genesisBlock time rawData) `shouldBe` 1

time = ""
rawData = C.pack "some data"
