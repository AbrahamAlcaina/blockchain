module CryptoSpec (spec) where

import           Crypto
import qualified Data.ByteString       as BS
import qualified Data.ByteString.Char8 as C
import           SpecHelper

spec::Spec
spec = describe "Crypto fixture" $ do
    it "Should Sign" $
        getByteStream `shouldBe` getHash
    {- generate private & public key
    it "should generate keys" $ do
        (pk, sk) <- createKeys
        BS.writeFile "./test/utils/sk" (unSecretKey sk)
        BS.writeFile "./test/utils/pk" (unPublicKey pk)
    -}
getByteStream = hashMsg $ C.pack "hola"
getHash = "42a46be94ae2242bdc13620cb065e64391059b8f909e27208293f462f3dd51669811446b3f8227c72bf6a1cf2628584429578b5d41756fbd02b40b45bfae8faf"

