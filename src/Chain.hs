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
getGenesisHash = C.pack "75e13da2e9a446e01594ee3fda021abb1d8cfc11d8bda49735b692c5ef632285c3c937eb159e68cee47c9e53f6f721f0a4cf2099c4c01509f84de5aa38fdba79"
