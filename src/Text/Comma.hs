{-# LANGUAGE Safe #-}

-- |
-- Module      : Text.Comma
-- Description : Join text together with a comma, and "and".
-- Maintainer  : hapytexeu+gh@gmail.com
-- Stability   : experimental
-- Portability : POSIX
--
-- This module provides functions to join elements of /string-like/ types by adding a comma between the elements, and an "and" (optionally with a comma) between the one-but-last and the last element.
module Text.Comma
  (
    CommaStyle (OxfordComma, NoComma),
    CommaValues(CommaValues, commaText, commaAndText),
    toCommaValues,
    lastJoin,
    -- * Join with commas and "and"
    commaAs,
    commaEmptyAs,
    commaWith,
    commaEmptyWith,
    comma,
    noComma,
    commaEmpty,
    noCommaEmpty,
    -- * Basic joining of elements
    combineWith,
    combineWithEmpty,
    -- * /String-like/ constants
    comma_,
    and_,
    commaAnd_,
  )
where

import Data.Default.Class (Default (def))
import Data.Foldable (toList)
import Data.String (IsString (fromString))

-- | The /string-like/ value for a comma, so @", "@.
comma_ ::
  (IsString s) =>
  -- | A /string-like/ type.
  s
comma_ = fromString ", "

-- | The /string-like/ value for an "and", so @" and "@.
and_ ::
  (IsString s) =>
  -- | A /string-like/ type.
  s
and_ = fromString " and "

-- | The /string-like/ value for a comma and an "and", so @", and "@.
commaAnd_ ::
  (IsString s) =>
  -- | A /string-like/ type.
  s
commaAnd_ = fromString ", and "

-- | A small data type that contains the /string-like/ values for the 'commaText, and the 'commaAndText': the join between the one but last, and last element. This can be used
-- to define a way to comma-and in a different language.
data CommaValues s
  = CommaValues  -- ^ The (only) data constructor that takes values for the comma and the "comma and" to join.
    {commaText :: s  -- ^ The text used to join two elements together, if the second element is /not/ the last element in the series.
    , commaAndText :: s  -- ^ The text used to join the one but last and the last element together.
    } deriving (Eq, Ord, Read, Show)

instance (IsString s) => Default (CommaValues s) where
  def = CommaValues comma_ commaAnd_

-- | Convert the given 'CommaStyle' to the corresponding 'CommaValue' item.
toCommaValues
  :: IsString s
  => CommaStyle  -- ^ The given 'CommaStyle' to convert into the corrsponding 'CommaValues' object.
  -> CommaValues s  -- ^ A 'CommaValues' object that contains the separators for the items.
toCommaValues OxfordComma = CommaValues comma_ commaAnd_
toCommaValues NoComma = CommaValues comma_ and_

-- | The two different ways to join the last two items together: with or without a comma.
data CommaStyle
  = -- | The /Oxford comma/ which uses a comma before the latest element, also known as /Harvard comma/ or /series comma/.
    OxfordComma
  | -- | The comma style where there is no comma before the "and" of the last item, informally known as the /Heathen comma/.
    NoComma
  deriving (Bounded, Enum, Eq, Ord, Read, Show)

instance Default CommaStyle where
  def = OxfordComma

-- | Specify the string that determines how to join the last but one and the last item based on the 'CommaStyle'.
lastJoin ::
  (IsString s) =>
  -- | The given comma style.
  CommaStyle ->
  -- | A string that specifies how to join the last but one item and the last item based on the comma style.
  s
lastJoin OxfordComma = commaAnd_
lastJoin _ = and_

-- | Join the 'Foldable' of elements with a given item for a comma and for the last join with a custom value if the 'Foldable' is empty.
combineWithEmpty ::
  (Semigroup s, Foldable f) =>
  -- | The item used if the foldable item is empty.
  s ->
  -- | The /comma/ item placed between each item and the next, except for the last join.
  s ->
  -- | The item used to join the one but last item and the last item.
  s ->
  -- | The 'Foldable' of items that should be joined.
  f s ->
  -- | The item generated by joining the elements with the comma and last join item.
  s
combineWithEmpty e c0 c1 = _combine e c0 c1 . toList

-- | Join the 'Foldable' of elements with a given item for a comma and for the last join.
combineWith ::
  (Monoid s, Foldable f) =>
  -- | The /comma/ item placed between each item and the next, except for the last join.
  s ->
  -- | The item used to join the one but last item and the last item.
  s ->
  -- | The 'Foldable' of items that should be joined.
  f s ->
  -- | The item generated by joining the elements with the comma and last join item.
  s
combineWith c0 c1 = _combine mempty c0 c1 . toList

_combine :: (Semigroup s) => s -> s -> s -> [s] -> s
_combine e _ _ [] = e
_combine _ _ _ [s] = s
_combine _ c0 c1 (x : x2 : xs) = go xs x x2
  where
    go [] s1 s2 = s1 <> c1 <> s2
    go (s3 : ss) s1 s2 = s1 <> c0 <> go ss s2 s3

-- | Joins the sequence of items with the /Oxford comma/ style, uses 'mempty' as empty string if there are no items.
comma
  :: (IsString s, Monoid s, Foldable f)
  => f s  -- ^ The 'Foldable' of string-like elements to join.
  -> s -- ^ The result that has joined the elements with commas and just "and" as last separator.
comma = combineWith comma_ commaAnd_

-- | Joins the sequence of items with the /no comma/ style, uses 'mempty' as empty string if there are no items.
noComma
  :: (IsString s, Monoid s, Foldable f)
  => f s  -- ^ The 'Foldable' of string-like elements to join.
  -> s  -- ^ The result that has joined the elements with commas, and ", and" (with comma) as last separator.
noComma = combineWith comma_ and_

-- | Join the sequence of items with the /Oxford comma/ style, uses a given "string" if there are no items.
commaEmpty
  :: (IsString s, Semigroup s, Foldable f)
  => s  -- ^ The item to return if the 'Foldable' is empty.
  -> f s  -- ^ The 'Foldable' of string-like elements to join.
  -> s -- ^ The result that has joined the elements with commas and just "and" as last separator.
commaEmpty e = combineWithEmpty e comma_ commaAnd_

-- | Join the sequence of items with the /no comma/ style, uses a given "string" if there are no items.
noCommaEmpty
  :: (IsString s, Semigroup s, Foldable f)
  => s  -- ^ The item to return if the 'Foldable' is empty.
  -> f s  -- ^ The 'Foldable' of string-like elements to join.
  -> s  -- ^ The result that has joined the elements with commas, and ", and" (with comma) as last separator.
noCommaEmpty e = combineWithEmpty e comma_ and_

-- | Join the sequence of items with the given comma style, uses 'mempty' as empty string if there are no items.
commaAs
  :: (IsString s, Monoid s, Foldable f)
  => CommaStyle  -- ^ The given 'CommaStyle' to use.
  -> f s  -- ^ The 'Foldable' of string-like elements to join.
  -> s  -- ^ The result that has joined the elements with commas as specified by the given 'CommaStyle'.
commaAs = combineWith comma_ . lastJoin

-- | Join the sequence of items with the given comma style, uses a given "string" if there are no items.
commaEmptyAs
  :: (IsString s, Semigroup s, Foldable f)
  => s  -- ^ The item to return if the 'Foldable' is empty.
  -> CommaStyle  -- ^ The given 'CommaStyle' to use.
  -> f s  -- ^ The 'Foldable' of string-like elements to join.
  -> s  -- ^ The result that has joined the elements with commas as specified by the given 'CommaStyle'.
commaEmptyAs e = combineWithEmpty e comma_ . lastJoin

-- | Join the sequence of items with the given 'CommaValues', uses 'mempty' as empty string if there are no items.
commaWith
  :: (IsString s, Monoid s, Foldable f)
  => CommaValues s  -- ^ A 'CommaValues' object that determines the normal separator and the last separator.
  -> f s  -- ^ The 'Foldable' of string-like elements to join.
  -> s  -- ^ The result that has joined the elements with commas as specified by the given 'CommaValues'.
commaWith ~(CommaValues c ca) = combineWith c ca

-- | Join the sequence of items with the given 'CommaValues', uses a given "string" if there are no items.
commaEmptyWith
  :: (IsString s, Semigroup s, Foldable f)
  => s  -- ^ The item to return if the 'Foldable' is empty.
  -> CommaValues s  -- ^ A 'CommaValues' object that determines the normal separator and the last separator.
  -> f s  -- ^ The 'Foldable' of string-like elements to join.
  -> s  -- ^ The result that has joined the elements with commas as specified by the given 'CommaValues'.
commaEmptyWith e ~(CommaValues c ca) = combineWithEmpty e c ca
