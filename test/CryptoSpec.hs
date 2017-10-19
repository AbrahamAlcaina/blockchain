module CryptoSpec (spec) where

import           Crypto
import           Crypto.Error
import           Crypto.PubKey.Ed25519 (sign)
import qualified Data.ByteString       as BS
import qualified Data.ByteString.Char8 as C
import           SpecHelper

spec::Spec
spec = describe "Feature: Cryptography" $ do
    describe "Scenario: User wants to get a hash of a message" $
        describe "Given I have a message `hola`" $
            it ("Then the hash is " ++ getHash) $
                getByteStream `shouldBe` getHash
    describe "Scenario: User wants to sign a message" $
        describe "Given When I have private and publick key" $ do
            describe "When I have two different messages " $
                it "Then I should have differents signatures" $ do
                    (pk, sk) <- createKeys
                    signSmallMsg sk pk msgBS `shouldNotBe` sign sk pk (C.pack "no")
            describe "When I have two equal messages" $
                it "Then I should have the same signature" $ do
                    (pk, sk) <- createKeys
                    signSmallMsg sk pk msgBS `shouldBe` sign sk pk msgBS
    {- generate private & public key
    it "should generate keys" $ do
        (pk, sk) <- createKeys
        BS.writeFile "./test/utils/sk" (unSecretKey sk)
        BS.writeFile "./test/utils/pk" (unPublicKey pk)
    -}
msg = "hola"
msgBS = C.pack msg
getByteStream = hashMsg msgBS
getHash = "42a46be94ae2242bdc13620cb065e64391059b8f909e27208293f462f3dd51669811446b3f8227c72bf6a1cf2628584429578b5d41756fbd02b40b45bfae8faf"
