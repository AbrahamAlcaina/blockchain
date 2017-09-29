module Chain (genesisBlock, getIndex, getPreviousHash) where

import qualified Data.ByteString       as BS
import qualified Data.ByteString.Char8 as C
import           Data.Time.Clock

type Blockchain = [Block]

data Block = Block { indexBlock::Int, timeStamp::String, rawData, hash, previousHash::BS.ByteString } deriving (Show)

genesisBlock :: Block
genesisBlock = Block {
  indexBlock= 0
  , timeStamp = "getCurrentTime"
  , rawData = C.pack "first block!"
  , hash = C.pack "816534932c2b7154836da6afc367695e6337db8a921823784c14378abed4f7d7"
  , previousHash = C.pack ""
}

nextBlock previous time raw = Block {
  indexBlock = indexBlock previous
  , timeStamp = time
  , rawData = raw
  , hash = ""
  , previousHash = previousHash previous
}

getIndex = indexBlock
getTimeStamp = timeStamp
getRawData = rawData
getHash = hash
getPreviousHash = C.unpack . previousHash
