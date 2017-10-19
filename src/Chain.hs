module Chain (genesisBlock, getIndex, getPreviousHash, getHash, getGenesisHash, nextBlock, getTimeStamp, getRawData) where

import           Crypto                (hashMsg)
import qualified Data.ByteString       as BS
import qualified Data.ByteString.Char8 as C
import           Data.Time.Clock

type Blockchain = [Block]

data Block = Block { indexBlock::Int, timeStamp::String, rawData, hash::BS.ByteString, previousHash::BS.ByteString }
  | GenesisBlock {indexBlock::Int, hash::BS.ByteString} deriving (Show)

genesisBlock :: Block
genesisBlock = GenesisBlock {
  indexBlock= 0
  , hash = getGenesisHash
}

nextBlock:: Block -> String -> BS.ByteString -> Block
nextBlock previousBlock time raw = Block {
  indexBlock = 1 + indexBlock previousBlock
  , timeStamp = time
  , rawData = raw
  , hash = C.pack $ hashMsg raw
  , previousHash = hash previousBlock
}

getIndex = indexBlock
getTimeStamp = timeStamp
getRawData = rawData
getHash = hash
getPreviousHash = previousHash
getGenesisHash = C.pack "816534932c2b7154836da6afc367695e6337db8a921823784c14378abed4f7d7"
