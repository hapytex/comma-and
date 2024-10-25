{-# LANGUAGE Safe #-}

{-|
Module      : Text.Comma
Description : Join text together with a comma, and "and".
Maintainer  : hapytexeu+gh@gmail.com
Stability   : experimental
Portability : POSIX

This module provides functions to join elements of /string-like/ types by adding a comma between the elements, and an "and" (optionally with a comma) between the one-but-last and the last element.
-}

module Text.Comma (
    comma_, and_, commaAnd_
  , CommaStyle(OxfordComma, NoComma)
  , lastJoin
  , commaAs, commaEmptyAs, comma, noComma, commaEmpty, noCommaEmpty
  , combineWith, combineWithEmpty
  ) where

import Data.Default.Class(Default(def))
import Data.Foldable(toList)
import Data.String(IsString(fromString))

-- | The /string-like/ value for a comma, so @", "@.
comma_
  :: IsString s
  => s  -- ^ A /string-like/ type.
comma_ = fromString ", "

-- | The /string-like/ value for an "and", so @" and "@.
and_
  :: IsString s
  => s  -- ^ A /string-like/ type.
and_ = fromString " and "

-- | The /string-like/ value for a comma and an "and", so @", and "@.
commaAnd_
  :: IsString s
  => s  -- ^ A /string-like/ type.
commaAnd_ = fromString ", and "

-- | The two different ways to join the last two items together: with or without a comma.
data CommaStyle
  = OxfordComma  -- ^ The /Oxford comma/ which uses a comma before the latest element, also known as /Harvard comma/ or /series comma/.
  | NoComma  -- ^ The comma style where there is no comma before the "and" of the last item, informally known as the /Heathen comma/.
  deriving (Bounded, Enum, Eq, Ord, Read, Show)

instance Default CommaStyle where
  def = OxfordComma

-- | Specify the string that determines how to join the last but one and the last item based on the 'CommaStyle'.
lastJoin
  :: IsString s
  => CommaStyle -- ^ The given comma style.
  -> s  -- ^ A string that specifies how to join the last but one item and the last item based on the comma style.
lastJoin OxfordComma = commaAnd_
lastJoin _ = and_

-- | Join the 'Foldable' of elements with a given item for a comma and for the last join with a custom value if the 'Foldable' is empty.
combineWithEmpty
  :: (Semigroup s, Foldable f)
  => s  -- ^ The item used if the foldable item is empty.
  -> s  -- ^ The /comma/ item placed between each item and the next, except for the last join.
  -> s  -- ^ The item used to join the one but last item and the last item.
  -> f s  -- ^ The 'Foldable' of items that should be joined.
  -> s  -- ^ The item generated by joining the elements with the comma and last join item.
combineWithEmpty e c0 c1 = _combine e c0 c1 . toList

-- | Join the 'Foldable' of elements with a given item for a comma and for the last join.
combineWith
  :: (Monoid s, Foldable f)
  => s  -- ^ The /comma/ item placed between each item and the next, except for the last join.
  -> s  -- ^ The item used to join the one but last item and the last item.
  -> f s  -- ^ The 'Foldable' of items that should be joined.
  -> s  -- ^ The item generated by joining the elements with the comma and last join item.
combineWith c0 c1 = _combine mempty c0 c1 . toList

_combine :: Semigroup s => s -> s -> s -> [s] -> s
_combine e _ _ [] = e
_combine _ _ _ [s] = s
_combine _ c0 c1 (x:x2:xs) = go xs x x2
  where go [] s1 s2 = s1 <> c1 <> s2
        go (s3:ss) s1 s2 = s1 <> c0 <> go ss s2 s3

-- | Joins the sequence of items with the /Oxford comma/ style, uses the empty string if there are no items.
comma :: (IsString s, Monoid s, Foldable f) => f s -> s
comma = combineWith comma_ commaAnd_

-- | Joins the sequence of items with the /no comma/ style, uses the empty string if there are no items.
noComma :: (IsString s, Monoid s, Foldable f) => f s -> s
noComma = combineWith comma_ and_

-- | Join the sequence of items with the /Oxford comma/ style, uses a given "string" if there are no items.
commaEmpty :: (IsString s, Semigroup s, Foldable f) => s -> f s -> s
commaEmpty e = combineWithEmpty e comma_ commaAnd_

-- | Join the sequence of items with the /no comma/ style, uses a given "string" if there are no items.
noCommaEmpty :: (IsString s, Semigroup s, Foldable f) => s -> f s -> s
noCommaEmpty e = combineWithEmpty e comma_ and_

-- | Join the sequence of items with the given comma style, uses the empty string if there are no items.
commaAs :: (IsString s, Monoid s, Foldable f) => CommaStyle -> f s -> s
commaAs = combineWith comma_ . lastJoin

-- | Join the sequence of items with the given comma style, uses a given "string" if there are no items.
commaEmptyAs :: (IsString s, Semigroup s, Foldable f) => s -> CommaStyle -> f s -> s
commaEmptyAs e = combineWithEmpty e comma_ . lastJoin
