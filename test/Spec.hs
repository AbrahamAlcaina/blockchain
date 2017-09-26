import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Main Test Suit" $ do
    it "Should be able to run test" $ do
      True `shouldBe` True
