module Text.CommaSpec where

import Data.Default.Class(Default(def))

import Test.Hspec(Spec, describe, it, shouldBe)
import Text.Comma(CommaStyle(OxfordComma, NoComma), CommaValues(commaText, commaAndText), comma, commaAs, commaEmpty, commaEmptyAs, commaEmptyWith, commaWith, lastJoin, noComma, noCommaEmpty, toCommaValues)

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
    it "commaWith" $ do
      commaWith (toCommaValues OxfordComma) [] `shouldBe` ""
      commaWith (toCommaValues OxfordComma) ["red"] `shouldBe` "red"
      commaWith (toCommaValues OxfordComma) ["red", "green"] `shouldBe` "red, and green"
      commaWith (toCommaValues OxfordComma) ["red", "green", "blue"] `shouldBe` "red, green, and blue"
      commaWith (toCommaValues NoComma) [] `shouldBe` ""
      commaWith (toCommaValues NoComma) ["red"] `shouldBe` "red"
      commaWith (toCommaValues NoComma) ["red", "green"] `shouldBe` "red and green"
      commaWith (toCommaValues NoComma) ["red", "green", "blue"] `shouldBe` "red, green and blue"
    it "commaEmptyWith" $ do
      commaEmptyWith "and" (toCommaValues OxfordComma) [] `shouldBe` "and"
      commaEmptyWith "and" (toCommaValues OxfordComma) ["red"] `shouldBe` "red"
      commaEmptyWith "and" (toCommaValues OxfordComma) ["red", "green"] `shouldBe` "red, and green"
      commaEmptyWith "and" (toCommaValues OxfordComma) ["red", "green", "blue"] `shouldBe` "red, green, and blue"
      commaEmptyWith "and" (toCommaValues NoComma) [] `shouldBe` "and"
      commaEmptyWith "and" (toCommaValues NoComma) ["red"] `shouldBe` "red"
      commaEmptyWith "and" (toCommaValues NoComma) ["red", "green"] `shouldBe` "red and green"
      commaEmptyWith "and" (toCommaValues NoComma) ["red", "green", "blue"] `shouldBe` "red, green and blue"
    it "lastJoin" $ do
      lastJoin OxfordComma `shouldBe` ", and "
      lastJoin NoComma `shouldBe` " and "
    it "CommaStyle" $ do
      def `shouldBe` OxfordComma
      minBound `shouldBe` OxfordComma
      maxBound `shouldBe` NoComma
      succ OxfordComma `shouldBe` NoComma
      compare OxfordComma NoComma `shouldBe` LT
    it "CommaValues" $ do
      toCommaValues def `shouldBe` def
      commaText (toCommaValues def) `shouldBe` commaText def
      commaAndText (toCommaValues def) `shouldBe` commaAndText def
