module Crypto (createKeys, hashMsg, sign, signBigMsg) where

import           Crypto.Hash            (Digest, hash)
import           Crypto.Hash.Algorithms (SHA3_512)
import           Crypto.PubKey.Ed25519  (PublicKey, SecretKey, Signature, generateSecretKey, sign,
                                         toPublic)
import qualified Data.ByteString        as BS
import qualified Data.ByteString.Char8  as C8


createKeys::IO (PublicKey, SecretKey)
createKeys = do
    sk <- generateSecretKey
    return (toPublic sk, sk)

hashMsg::BS.ByteString -> String
hashMsg bs = show (hash bs :: Digest SHA3_512)

signSmallMsg:: SecretKey -> PublicKey -> BS.ByteString  -> Signature
signSmallMsg = sign

signBigMsg:: SecretKey -> PublicKey -> BS.ByteString -> Signature
signBigMsg sk pk msg = signSmallMsg sk pk  $ C8.pack (hashMsg msg)
