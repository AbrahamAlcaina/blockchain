module ChainSpec (spec) where

import           Chain
import           Crypto                (hashMsg)
import qualified Data.ByteString       as BS
import qualified Data.ByteString.Char8 as C
import           Data.Time.Clock
import           SpecHelper
import           System.IO


rawData = C.pack "some data"
calculateHash :: BS.ByteString -> Int -> BS.ByteString
calculateHash raw nonce = hashMsg $ BS.append raw (C.pack $ show nonce)

mkBlock:: IO (UTCTime, Block)
mkBlock = do
    time <- getCurrentTime
    return (time, nextBlock genesisBlock time rawData 0)

spec::Spec
spec =
    describe "Feature: Blockchain" $
        context "Given the user have a blockchain" $
            context "When I have a genesisBlock"$ do
                it "Then It should have index 0" $
                    getIndex genesisBlock `shouldBe` 0
                it "And It should have an specific hash" $
                    getHash genesisBlock `shouldBe` getGenesisHash
                it "written block shold be" $
                    show genesisBlock `shouldBe` ("GenesisBlock {indexBlock = 0, hash = " ++ show getGenesisHash ++ "}" )
                context "When I create a new block" $ do
                    it "Then the new block should point the genesis block index" $ do
                        (time,block) <- mkBlock
                        getHashpointIndex (getPrevious block) `shouldBe` 0
                    it "Then the new block should point the genesis block hash" $ do
                        (time,block) <- mkBlock
                        getHashpointHash (getPrevious block) `shouldBe` getGenesisHash
                    it "Then the new block should have the rawData" $ do
                        (time,block) <- mkBlock
                        getRawData block `shouldBe` rawData
                    it "Then the new block should have index 1" $ do
                        (time,block) <- mkBlock
                        getIndex block `shouldBe` 1
                    it "Then the new block should have the correct time" $ do
                        (time,block) <- mkBlock
                        getTimeStamp block `shouldBe` time
                    it "Then the new block should have the correct hash" $ do
                        (time,block) <- mkBlock
                        getHash block `shouldBe` calculateHash rawData (getNonce block)
                    it "Then the new block should have nonce 0" $ do
                        (time, block)<- mkBlock
                        getNonce block `shouldBe` 0
                    it "Then the show should work" $ do
                        (_, block) <- mkBlock
                        show block `shouldNotBe` ""

