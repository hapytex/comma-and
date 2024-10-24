{-# LANGUAGE Safe #-}

{-|
Module      : Text.Comma
Description : Join text together with a comma, and "and".
Maintainer  : hapytexeu+gh@gmail.com
Stability   : experimental
Portability : POSIX

-}

module Text.Comma (
    comma_, and_, commaAnd_
  , CommaStyle(OxfordComma, NoComma)
  , lastJoin
  , _combine
  ) where

import Data.Default.Class(Default(def))
import Data.Foldable(toList)
import Data.String(IsString(fromString))

comma_ :: IsString s => s
comma_ = fromString ", "

and_ :: IsString s => s
and_ = fromString " and "

commaAnd_ :: IsString s => s
commaAnd_ = fromString ", and "

-- | The two different ways to join the last two items together: with or without a comma.
data CommaStyle
  = OxfordComma  -- ^ The /Oxford comma/ which uses a comma before the latest element.
  | NoComma
  deriving (Bounded, Enum, Eq, Ord, Read, Show)

instance Default CommaStyle where
  def = OxfordComma

lastJoin :: IsString s => CommaStyle -> s
lastJoin OxfordComma = commaAnd_
lastJoin _ = and_

combineWithEmpty :: (IsString s, Semigroup s, Foldable f) => s -> s -> s -> f s -> s
combineWithEmpty e c0 c1 = _combine e c0 c1 . toList

combineWith :: (IsString s, Monoid s, Foldable f) => s -> s -> f s -> s
combineWith c0 c1 = _combine mempty c0 c1 . toList

_combine :: (IsString s, Semigroup s) => s -> s -> s -> [s] -> s
_combine e _ _ [] = e
_combine _ _ _ [s] = s
_combine _ c0 c1 (s:s2:ss) = go ss s s2
  where go [] s1 s2 = s1 <> c1 <> s2
        go (s3:ss) s1 s2 = s1 <> c0 <> go ss s2 s3

comma :: (IsString s, Monoid s, Foldable f) => f s -> s
comma = combineWith comma_ commaAnd_

noComma :: (IsString s, Monoid s, Foldable f) => f s -> s
noComma = combineWith comma_ and_

commaEmpty :: (IsString s, Semigroup s, Foldable f) => s -> f s -> s
commaEmpty e = combineWithEmpty e comma_ commaAnd_

noCommaEmpty :: (IsString s, Semigroup s, Foldable f) => s -> f s -> s
noCommaEmpty e = combineWithEmpty e comma_ and_
