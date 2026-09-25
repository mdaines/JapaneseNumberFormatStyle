# JapaneseNumberFormatStyle

Swift package for formatting numbers in Japanese.

## JapaneseKanaNumberFormatStyle

`JapaneseKanaNumberFormatStyle` formats an integer as its spelling in Japanese kana.

All of the Swift standard library's integer types work with this format style. It supports units up to 10^36 (澗, かん), negative integers, and zero.

### Spelling

This format style attempts to use the most conventional spelling. For example:

Integer | Spelling
--------|---------
4       | よん
0       | ゼロ
-12     | マイナスじゅうに

### Formatting Integers

You can specify `.japaneseKana` when using `formatted(_:)`.

```swift
123.formatted(.japaneseKana) // "ひゃくにじゅうさん".
```

Or when formatting a value in a SwiftUI `Text` view.

```swift
Text(123, format: .japaneseKana)
```

When formatting multiple integers, create an instance of `JapaneseKanaNumberFormatStyle`.

```swift
let kanaFormatStyle = JapaneseKanaNumberFormatStyle<Int>()

kanaFormatStyle.format(8) // "はち"
kanaFormatStyle.format(123) // "ひゃくにじゅうさん"
kanaFormatStyle.format(0) // "ゼロ"
```

### Grouping

Formatted numbers can be grouped by place (numeral and unit) to make them easier to read. For example, setting the `.place` grouping behavior with the separator `"\u{3000}"` inserts an ideographic space character between places in the formatted number:

```swift
let formattedNumber = 123.formatted(
    .japaneseKana
    .grouping(.place(separator: "\u{3000}"))
)
// formattedNumber is "ひゃく　にじゅう　さん".
```