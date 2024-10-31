# comma-and
[![Build Status of the package by GitHub actions](https://github.com/hapytex/comma-and/actions/workflows/build-ci.yml/badge.svg)](https://github.com/hapytex/comma-and/actions/workflows/build-ci.yml)
[![Build Status of the package by Hackage](https://matrix.hackage.haskell.org/api/v2/packages/comma-and/badge)](https://matrix.hackage.haskell.org/#/package/comma-and)
[![Hackage version badge](https://img.shields.io/hackage/v/comma-and.svg)](https://hackage.haskell.org/package/comma-and)

Joins text items together by separating these with commas, and "and" at the end.

## Usage

We can combine elements with:

```
ghci> comma ["red", "green", "blue"]
"red, green, and blue"
```

The package has tooling for the two different comma styles, and can work with any *string-like* type.

## *String-like* types?

The package can work with types that are an instance of `IsString` and `Monoid`. So this means it works with `String`, [`Text`](https://hackage.haskell.org/package/text/docs/Data-Text-Internal-Lazy.html#t:Text), [`ByteString`](https://hackage.haskell.org/package/bytestring/docs/Data-ByteString.html#t:ByteString), [`MarkupM`](https://hackage.haskell.org/package/blaze-markup/docs/Text-Blaze-Internal.html#t:MarkupM), [`LaTeX`](https://hackage.haskell.org/package/HaTeX-3.22.4.2/docs/Text-LaTeX-Base-Syntax.html#t:LaTeX), and probably a lot more types that concatenate with the `Monoid` instance, and are an instance of `IsString`.

## `comma-and` is *safe* Haskell

The module is compiled with `Safe` and does not depend on unsafe modules.

## Contribute

You can contribute by making a pull request on the [*GitHub repository*](https://github.com/hapytex/comma-and).

You can contact the package maintainer by sending a mail to [`hapytexeu+gh@gmail.com`](mailto:hapytexeu+gh@gmail.com).
