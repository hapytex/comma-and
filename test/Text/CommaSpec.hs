module Text.CommaSpec where

import Test.Hspec(Spec, describe, it, shouldBe)
import Text.Comma(comma)

spec :: Spec
spec = describe "comma" $ do
    it "comma" $ do
      comma [] `shouldBe` ""
      comma ["red"] `shouldBe` "red"
      comma ["red", "green"] `shouldBe` "red, and green"
      comma ["red", "green", "blue"] `shouldBe` "red, green, and blue"
