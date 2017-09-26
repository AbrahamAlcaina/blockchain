module Blockchain where

  import qualified Data.ByteString as BS
  import qualified Data.ByteString.Char8 as C
  import Data.Time.Clock

  data Block = Block {
    index::Int
    , timeStamp::String
    , rawData::BS.ByteString
    , hash::String
    , previousHash::String
  } deriving (Show)

  genesisBlock = Block {index= 0
    , timeStamp = "getCurrentTime"
    , rawData = C.pack "first block!"
    , hash = "816534932c2b7154836da6afc367695e6337db8a921823784c14378abed4f7d7"
    , previousHash = ""
  }
