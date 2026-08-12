import Foundation

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int> {
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int16> {
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int32> {
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int64> {
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<Int8> {
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt> {
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt16> {
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt32> {
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt64> {
    static var japaneseKana: Self { Self() }
}

public extension FormatStyle where Self == JapaneseKanaNumberFormatStyle<UInt8> {
    static var japaneseKana: Self { Self() }
}

public struct JapaneseKanaNumberFormatStyle<Value: BinaryInteger>: FormatStyle {
    public init() {
    }

    public func format(_ value: Value) -> String {
        guard value != 0 else {
            return "ゼロ"
        }

        var result = ""
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
            result = "マイナス" + result
        }

        return result
    }
}

let numerals = ["", "いち", "に", "さん", "よん", "ご", "ろく", "なな", "はち", "きゅう"]

func formatGroup(_ group: Int, value: Int) -> String {
    if value == 0 {
        ""
    } else {
        format3((value / 1000) % 10) +
        format2((value / 100) % 10) +
        format1((value / 10) % 10) +
        formatGroupUnit(group, value % 10)
    }
}

func formatGroupUnit(_ group: Int, _ n: Int) -> String {
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
    default:
        preconditionFailure()
    }
}

func format0(_ n: Int) -> String {
    numerals[n]
}

func format1(_ n: Int) -> String {
    switch n {
    case 0:
        ""
    case 1:
        "じゅう"
    case 2..<10:
        numerals[n] + "じゅう"
    default:
        preconditionFailure()
    }
}

func format2(_ n: Int) -> String {
    switch n {
    case 0:
        ""
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

func format3(_ n: Int) -> String {
    switch n {
    case 0:
        ""
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

func format4(_ n: Int) -> String {
    if n == 0 {
        "まん"
    } else {
        numerals[n] + "まん"
    }
}

func format8(_ n: Int) -> String {
    if n == 0 {
        "おく"
    } else {
        numerals[n] + "おく"
    }
}

func format12(_ n: Int) -> String {
    if n == 0 {
        "ちょう"
    } else if n == 1 {
        "いっちょう"
    } else {
        numerals[n] + "ちょう"
    }
}

func format16(_ n: Int) -> String {
    if n == 0 {
        "きょう"
    } else if n == 1 {
        "いっきょう"
    } else {
        numerals[n] + "きょう"
    }
}
