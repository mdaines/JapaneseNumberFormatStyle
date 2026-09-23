import Foundation

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int> {
    /// A style for formatting the Swift default integer type.
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int16> {
    /// A style for formatting 16-bit signed integers.
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int32> {
    /// A style for formatting 32-bit signed integers.
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int64> {
    /// A style for formatting 64-bit signed integers.
    static var japaneseKana: Self { Self() }
}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int128> {
    /// A style for formatting 128-bit signed integers.
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int8> {
    /// A style for formatting 8-bit signed integers.
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt> {
    /// A style for formatting the Swift unsigned integer type.
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt16> {
    /// A style for formatting 16-bit unsigned integers.
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt32> {
    /// A style for formatting 32-bit unsigned integers.
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt64> {
    /// A style for formatting 64-bit unsigned integers.
    static var japaneseKana: Self { Self() }
}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt128> {
    /// A style for formatting 128-bit unsigned integers.
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt8> {
    /// A style for formatting 8-bit unsigned integers.
    static var japaneseKana: Self { Self() }
}

/// A structure that converts integer values to Japanese kana.
///
/// `JapaneseKanaNumberFormatStyle` formats an integer as its spelling in Japanese kana.
///
/// All of the Swift standard library's integer types work with this format style. It supports units up to 10^36 (澗, かん), negative integers, and zero.
///
/// ### Spelling
///
/// This format style attempts to use the most conventional spelling. For example:
///
/// Integer | Spelling
/// --------|---------
/// 4       | よん
/// 0       | ゼロ
/// -12     | マイナスじゅうに
///
/// ### Formatting Integers
///
/// You can specify `.japaneseKana` when using `formatted(_:)`.
///
/// ```swift
/// let formattedNumber = 123.formatted(.japaneseKana)
/// // formattedNumber is "ひゃくにじゅうさん".
/// ```
///
/// Or when formatting a value in a SwiftUI `Text` view.
///
/// ```swift
/// Text(123, format: .japaneseKana)
/// ```
///
/// When formatting multiple integers, create an instance of `JapaneseKanaNumberFormatStyle`.
///
/// ```swift
/// let kanaFormatStyle = JapaneseKanaNumberFormatStyle<Int>()
///
/// kanaFormatStyle.format(8) // "はち"
/// kanaFormatStyle.format(123) // "ひゃくにじゅうさん"
/// kanaFormatStyle.format(0) // "ゼロ"
/// ```
///
/// ### Grouping
///
/// Formatted numbers can be grouped by place (numeral and unit) to make them easier to read. For example, setting the `.place` grouping behavior with the separator `"\u{3000}"` inserts an ideographic space character between places in the formatted number:
///
/// ```swift
/// let formattedNumber = 123.formatted(
///     .japaneseKana
///     .grouping(.place(separator: "\u{3000}"))
/// )
/// // formattedNumber is "ひゃく　にじゅう　さん".
/// ```

public struct JapaneseKanaNumberFormatStyle<Value: BinaryInteger>: FormatStyle {
    /// The type the format style uses for configuration settings.
    public typealias Configuration = JapaneseKanaNumberFormatStyleConfiguration

    var config: Configuration.Collection = Configuration.Collection()

    /// Creates a format style for formatting integers as Japanese kana.
    public init() {
    }

    /// Creates a format style for formatting integers as Japanese kana that uses the specified grouping.
    /// - Parameters:
    ///     - grouping: The grouping to use when formatting values.
    public func grouping(_ grouping: Configuration.Grouping) -> Self {
        var new = self
        new.config.grouping = grouping
        return new
    }

    typealias Vocabulary = JapaneseKanaNumberFormatStyleVocabulary

    /// Returns a string for the given integer value.
    public func format(_ value: Value) -> String {
        guard value != 0 else {
            return Vocabulary.zero
        }

        var result: [String] = []
        var group = 0
        var m = value.magnitude

        // Since 1_0000 overflows Int8 and similar, call formatGroup exactly once if the magnitude is small enough.

        if m < Int(1_0000) {
            result = formatGroup(group, value: Int(m))
        } else {
            while m > 0 {
                result = formatGroup(group, value: Int(m % 1_0000)) + result

                m /= 1_0000
                group += 1
            }
        }

        if value < 0 {
            result = [Vocabulary.minus] + result
        }

        return result.joined(separator: config.grouping?.placeSeparator ?? "")
    }

    func formatGroup(_ group: Int, value: Int) -> [String] {
        guard value != 0 else { return [] }

        var result: [String] = []

        if let place = Vocabulary.format3((value / 1000) % 10) {
            result.append(place)
        }

        if let place = Vocabulary.format2((value / 100) % 10) {
            result.append(place)
        }

        if let place = Vocabulary.format1((value / 10) % 10) {
            result.append(place)
        }

        if let place = formatGroupUnit(group, value % 10) {
            result.append(place)
        }

        return result
    }

    func formatGroupUnit(_ group: Int, _ n: Int) -> String? {
        switch group {
        case 0: Vocabulary.format0(n)
        case 1: Vocabulary.format4(n)
        case 2: Vocabulary.format8(n)
        case 3: Vocabulary.format12(n)
        case 4: Vocabulary.format16(n)
        case 5: Vocabulary.format20(n)
        case 6: Vocabulary.format24(n)
        case 7: Vocabulary.format28(n)
        case 8: Vocabulary.format32(n)
        case 9: Vocabulary.format36(n)
        default:
            preconditionFailure()
        }
    }
}
