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
/// 123.formatted(.japaneseKana) // "ひゃくにじゅうさん"
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
/// let formatStyle = JapaneseKanaNumberFormatStyle<Int>(
///     grouping: .place(separator: "\u{3000}")
/// )
///
/// kanaFormatStyle.format(123) // "ひゃく　にじゅう　さん"
/// ```

public struct JapaneseKanaNumberFormatStyle<Value: BinaryInteger>: FormatStyle {
    /// The type the format style uses for configuration settings.
    public typealias Configuration = JapaneseKanaNumberFormatStyleConfiguration

    let grouping: Configuration.Grouping

    /// Creates a format style for formatting integers as Japanese kana.
    public init() {
        self.grouping = .never
    }

    /// Creates a format style for formatting integers as Japanese kana that uses the specified grouping.
    /// - Parameters:
    ///     - grouping: The grouping to use when formatting values.
    public init(grouping: Configuration.Grouping) {
        self.grouping = grouping
    }

    /// Modifies the format style to use the specified grouping.
    /// - Parameters:
    ///     - grouping: The grouping to apply to the format style.
    ///  - Returns: A format style modified to use the specified grouping.
    public func grouping(_ grouping: Configuration.Grouping) -> Self {
        Self(grouping: grouping)
    }

    func joinedPlaces(_ places: [String?]) -> String {
        if let placeSeparator = grouping.placeSeparator {
            places.compactMap({ $0 }).joined(separator: placeSeparator)
        } else {
            places.compactMap({ $0 }).joined()
        }
    }

    /// Returns a string for the given integer value.
    public func format(_ value: Value) -> String {
        guard value != 0 else {
            return "ゼロ"
        }

        var result: [String?] = []
        var group = 0
        var m = value.magnitude

        // Since 1_0000 overflows Int8 and similar, call formatGroup exactly once if the magnitude is small enough.

        if m < 1_0000 {
            result = formatGroup(group, value: Int(m))
        } else {
            while m > 0 {
                result = formatGroup(group, value: Int(m % 1_0000)) + result

                m /= 1_0000
                group += 1
            }
        }

        if value < 0 {
            result = ["マイナス"] + result
        }

        return joinedPlaces(result)
    }
}

public enum JapaneseKanaNumberFormatStyleConfiguration {
    /// A structure that a Japanese kana number format style uses to configure grouping.
    public struct Grouping: Codable, Hashable, Sendable {
        /// A grouping behavior that inserts the specified separator between places.
        public static func place(separator: String) -> Self {
            Self(placeSeparator: separator)
        }

        /// A grouping behavior that never groups places.
        public static var never: Self {
            Self(placeSeparator: nil)
        }

        let placeSeparator: String?
    }
}

let numerals = ["", "いち", "に", "さん", "よん", "ご", "ろく", "なな", "はち", "きゅう"]

func formatGroup(_ group: Int, value: Int) -> [String?] {
    if value == 0 {
        []
    } else {
        [
            format3((value / 1000) % 10),
            format2((value / 100) % 10),
            format1((value / 10) % 10),
            formatGroupUnit(group, value % 10)
        ]
    }
}

func formatGroupUnit(_ group: Int, _ n: Int) -> String? {
    switch group {
    case 0:
        format0(n)
    case 1:
        format4(n)
    case 2:
        format8(n)
    case 3:
        format12(n)
    case 4:
        format16(n)
    case 5:
        format20(n)
    case 6:
        format24(n)
    case 7:
        format28(n)
    case 8:
        format32(n)
    case 9:
        format36(n)
    default:
        preconditionFailure()
    }
}

func format0(_ n: Int) -> String? {
    numerals[n]
}

func format1(_ n: Int) -> String? {
    switch n {
    case 0:
        nil
    case 1:
        "じゅう"
    case 2..<10:
        numerals[n] + "じゅう"
    default:
        preconditionFailure()
    }
}

func format2(_ n: Int) -> String? {
    switch n {
    case 0:
        nil
    case 1:
        "ひゃく"
    case 3:
        "さんびゃく"
    case 6:
        "ろっぴゃく"
    case 8:
        "はっぴゃく"
    case 2, 4, 5, 7, 9:
        numerals[n] + "ひゃく"
    default:
        preconditionFailure()
    }
}

func format3(_ n: Int) -> String? {
    switch n {
    case 0:
        nil
    case 1:
        "せん"
    case 3:
        "さんぜん"
    case 8:
        "はっせん"
    case 2, 4, 5, 6, 7, 9:
        numerals[n] + "せん"
    default:
        preconditionFailure()
    }
}

func format4(_ n: Int) -> String? {
    if n == 0 {
        "まん"
    } else {
        numerals[n] + "まん"
    }
}

func format8(_ n: Int) -> String? {
    if n == 0 {
        "おく"
    } else {
        numerals[n] + "おく"
    }
}

func format12(_ n: Int) -> String? {
    if n == 0 {
        "ちょう"
    } else if n == 1 {
        "いっちょう"
    } else {
        numerals[n] + "ちょう"
    }
}

func format16(_ n: Int) -> String? {
    if n == 0 {
        "きょう"
    } else if n == 1 {
        "いっきょう"
    } else {
        numerals[n] + "きょう"
    }
}

func format20(_ n: Int) -> String? {
    numerals[n] + "がい"
}

func format24(_ n: Int) -> String? {
    numerals[n] + "じょ"
}

func format28(_ n: Int) -> String? {
    numerals[n] + "じょう"
}

func format32(_ n: Int) -> String? {
    numerals[n] + "こう"
}

func format36(_ n: Int) -> String? {
    numerals[n] + "かん"
}
