module CryptoSpec (spec) where

import           Crypto
import qualified Data.ByteString.Char8 as C
import           SpecHelper

spec::Spec
spec = describe "Crypto fixture" $
    it "Should Sign" $
        getByteStream `shouldBe` C.pack getHash


getByteStream = hashMsg $ C.pack "hola"
getHash = "\232>\133\&5\214\246\137I>X\EM\189`\170>_\220\186\148\SOm\DC1\SUB\182\251\\4\242O\134Ik\243rn+\244\236Y\214\210\245\162\174\177\228\241\ETX(>}d\228\244\156\ETX\180\196r\\\179a\231s"

