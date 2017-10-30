module Chain (
  genesisBlock
  , getIndex
  , getPrevious
  , getHash
  , getGenesisHash
  , nextBlock
  , getTimeStamp
  , getRawData
  , getHashpointIndex
  , getHashpointHash
  , Blockchain
  , Block
  , HashPoint) where

import           Crypto                (HashAlgoritm, hashMsg)
import qualified Data.ByteString       as BS
import qualified Data.ByteString.Char8 as C
import           Data.Time.Clock
import           Data.Vector           (Vector)

type Blockchain = Vector Block

data HashPoint = HashPoint {
  index::Int, hashPoint::BS.ByteString
} deriving (Show, Eq)

data Block = Block {
  indexBlock::Int
  , timeStamp::UTCTime
  , rawData
  , hash::BS.ByteString
  , previous::HashPoint
} | GenesisBlock {
  indexBlock::Int, hash::BS.ByteString
} deriving (Show)

{--
data Transaction = Transaction {
  inputCount::Int, outputCount::Int, version::Int, inputs::Vector InputTx, outputs::Vector OutputTx
} deriving (Show)

data InputTx = InputTx {
  prevTxId::HashPoint, outputIndex::Int
} deriving (Show)

data OutputTx = OutputTx {
  coins::Int, signatures::Vector HashAlgoritm
} deriving (Show)
--}

genesisBlock :: Block
genesisBlock = GenesisBlock {
  indexBlock= 0
  , hash = getGenesisHash
}

nextBlock:: Block -> UTCTime -> BS.ByteString -> Block
nextBlock previousBlock time raw = Block {
  indexBlock = 1 + indexBlock previousBlock
  , timeStamp = time
  , rawData = raw
  , hash = C.pack $ hashMsg raw -- include timestamp and indexblock also
  , previous = HashPoint (indexBlock previousBlock) (hash previousBlock)
}

getIndex = indexBlock
getTimeStamp = timeStamp
getRawData = rawData
getHash = hash
getPrevious = previous
getGenesisHash = C.pack "75e13da2e9a446e01594ee3fda021abb1d8cfc11d8bda49735b692c5ef632285c3c937eb159e68cee47c9e53f6f721f0a4cf2099c4c01509f84de5aa38fdba79"
getHashpointIndex = index
getHashpointHash = hashPoint
