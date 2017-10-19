module Crypto (createKeys, hashMsg, signSmallMsg, signBigMsg) where

import           Crypto.Error
import           Crypto.Hash            (Digest, hash)
import           Crypto.Hash.Algorithms (SHA3_512)
import           Crypto.PubKey.Ed25519  (PublicKey, SecretKey, Signature, generateSecretKey, sign,
                                         toPublic)

import qualified Data.ByteString        as BS
import qualified Data.ByteString.Char8  as C

type HashAlgoritm = Digest SHA3_512

createKeys :: IO (PublicKey, SecretKey)
createKeys = do
    sk <- generateSecretKey
    return (toPublic sk, sk)

hashMsg::BS.ByteString -> String
hashMsg bs = show (hash bs :: HashAlgoritm)

signSmallMsg:: SecretKey -> PublicKey -> BS.ByteString  -> Signature
signSmallMsg = sign

signBigMsg:: SecretKey -> PublicKey -> BS.ByteString -> Signature
signBigMsg sk pk msg = signSmallMsg sk pk  $ C.pack (hashMsg msg)
