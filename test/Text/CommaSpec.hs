module Text.CommaSpec where

import Data.Default.Class(Default(def))

import Test.Hspec(Spec, describe, it, shouldBe)
import Text.Comma(CommaStyle(OxfordComma, NoComma), comma, commaAs, commaEmpty, commaEmptyAs, lastJoin, noComma, noCommaEmpty)

spec :: Spec
spec = describe "and" $ do
    it "comma" $ do
      comma [] `shouldBe` ""
      comma ["red"] `shouldBe` "red"
      comma ["red", "green"] `shouldBe` "red, and green"
      comma ["red", "green", "blue"] `shouldBe` "red, green, and blue"
    it "commaEmpty" $ do
      commaEmpty "and" [] `shouldBe` "and"
      commaEmpty "and" ["red"] `shouldBe` "red"
      commaEmpty "and" ["red", "green"] `shouldBe` "red, and green"
      commaEmpty "and" ["red", "green", "blue"] `shouldBe` "red, green, and blue"
    it "noComma" $ do
      noComma [] `shouldBe` ""
      noComma ["red"] `shouldBe` "red"
      noComma ["red", "green"] `shouldBe` "red and green"
      noComma ["red", "green", "blue"] `shouldBe` "red, green and blue"
    it "noCommaEmpty" $ do
      noCommaEmpty "and" [] `shouldBe` "and"
      noCommaEmpty "and" ["red"] `shouldBe` "red"
      noCommaEmpty "and" ["red", "green"] `shouldBe` "red and green"
      noCommaEmpty "and" ["red", "green", "blue"] `shouldBe` "red, green and blue"
    it "commaAs" $ do
      commaAs OxfordComma [] `shouldBe` ""
      commaAs OxfordComma ["red"] `shouldBe` "red"
      commaAs OxfordComma ["red", "green"] `shouldBe` "red, and green"
      commaAs OxfordComma ["red", "green", "blue"] `shouldBe` "red, green, and blue"
      commaAs NoComma [] `shouldBe` ""
      commaAs NoComma ["red"] `shouldBe` "red"
      commaAs NoComma ["red", "green"] `shouldBe` "red and green"
      commaAs NoComma ["red", "green", "blue"] `shouldBe` "red, green and blue"
    it "commaEmptyAs" $ do
      commaEmptyAs "and" OxfordComma [] `shouldBe` "and"
      commaEmptyAs "and" OxfordComma ["red"] `shouldBe` "red"
      commaEmptyAs "and" OxfordComma ["red", "green"] `shouldBe` "red, and green"
      commaEmptyAs "and" OxfordComma ["red", "green", "blue"] `shouldBe` "red, green, and blue"
      commaEmptyAs "and" NoComma [] `shouldBe` "and"
      commaEmptyAs "and" NoComma ["red"] `shouldBe` "red"
      commaEmptyAs "and" NoComma ["red", "green"] `shouldBe` "red and green"
      commaEmptyAs "and" NoComma ["red", "green", "blue"] `shouldBe` "red, green and blue"
    it "lastJoin" $ do
      lastJoin OxfordComma `shouldBe` ", and "
      lastJoin NoComma `shouldBe` " and "
    it "CommaStyle" $ do
      def `shouldBe` OxfordComma
      minBound `shouldBe` OxfordComma
      maxBound `shouldBe` NoComma
      succ OxfordComma `shouldBe` NoComma
      compare OxfordComma NoComma `shouldBe` LT
