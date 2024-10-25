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

## `comma-and` is *safe* Haskell

The module is compiled with `Safe` and does not depend on unsafe modules.

## Contribute

You can contribute by making a pull request on the [*GitHub repository*](https://github.com/hapytex/comma-and).

You can contact the package maintainer by sending a mail to [`hapytexeu+gh@gmail.com`](mailto:hapytexeu+gh@gmail.com).
