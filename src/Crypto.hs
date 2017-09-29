module Crypto (createKeys, hashMsg, sign, signBigMsg) where

import           Crypto.Hash.SHA512
import           Crypto.Sign.Ed25519
import qualified Data.ByteString     as BS

createKeys::IO (PublicKey, SecretKey)
createKeys = createKeypair

hashMsg::BS.ByteString -> BS.ByteString
hashMsg = hash

signSmallMsg:: SecretKey -> BS.ByteString -> Signature
signSmallMsg = dsign

signBigMsg:: SecretKey -> BS.ByteString -> Signature
signBigMsg sk msg = signSmallMsg sk (hash msg)
